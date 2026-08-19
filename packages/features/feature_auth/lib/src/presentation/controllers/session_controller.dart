import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:feature_auth/src/di.dart';
import 'package:feature_auth/src/domain/entities/auth_status.dart';
import 'package:feature_auth/src/domain/entities/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_controller.g.dart';

/// 전역 인증 상태 컨트롤러.
///
/// 화면 단위 MVI ViewModel이 아니라 앱 수준의 세션 상태다.
/// 라우터의 redirect가 이 상태를 구독해 로그인/홈 분기를 결정하므로
/// 화면에서 직접 네비게이션하지 않는다 — 상태만 바꾸면 라우터가 반응한다.
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  AuthStatus build() => const AuthUnknown();

  /// 앱 시작 시 저장된 토큰으로 세션을 복원한다. bootstrap에서 호출된다.
  ///
  /// 실패 원인별 분기는 Repository가 담당한다 (auth_repository_impl 참고):
  /// 401은 세션 폐기 후 Success(null), 오프라인 등 일시 장애는 저장된
  /// 프로필 스냅샷으로 Success(user)가 온다. 여기서 Failure는
  /// "복원 판정 불가 + 스냅샷 없음"(사실상 최초 실행 오프라인)뿐이다.
  Future<void> restore() async {
    final result = await ref.read(authRepositoryProvider).restoreSession();
    state = result.fold(
      onSuccess: (user) =>
          user != null ? Authenticated(user) : const Unauthenticated(),
      onFailure: (_) => const Unauthenticated(),
    );
  }

  /// 로그인 성공 시 LoginViewModel이 호출한다.
  void onLoggedIn(AuthUser user) {
    state = Authenticated(user);
  }

  /// 명시적 로그아웃과 401 세션 만료 처리 양쪽에서 호출된다.
  Future<void> logout() async {
    final result = await ref.read(authRepositoryProvider).logout();

    // 토큰 삭제 실패(Keystore 오류 등)를 조용히 넘기지 않는다 — 보고 후
    // UI 전이는 진행한다. 디스크에 남은 토큰은 다음 restore()의 서버
    // 재검증(401 → 세션 폐기)이 회수한다.
    if (result case Failure(:final exception)) {
      unawaited(
        ref
            .read(errorReporterProvider)
            .report(exception, exception.stackTrace ?? StackTrace.current),
      );
    }

    state = const Unauthenticated();
  }
}
