import 'package:feature_auth/src/domain/entities/auth_user.dart';

/// 전역 인증 상태.
///
/// 라우터의 redirect는 이 상태만 보고 로그인/홈 분기를 결정한다.
sealed class AuthStatus {
  const AuthStatus();
}

/// 앱 시작 직후 세션 복원이 끝나기 전. 스플래시를 유지하는 근거가 된다.
final class AuthUnknown extends AuthStatus {
  const AuthUnknown();
}

final class Authenticated extends AuthStatus {
  const Authenticated(this.user);

  final AuthUser user;
}

final class Unauthenticated extends AuthStatus {
  const Unauthenticated();
}
