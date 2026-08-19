import 'package:app_core/app_core.dart';

import 'package:feature_auth/src/domain/entities/auth_user.dart';

/// 인증 저장소 계약.
///
/// domain 계층은 인터페이스만 정의하고, 구현은 data 계층이 담당한다.
/// presentation은 이 인터페이스에만 의존한다.
abstract interface class AuthRepository {
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();

  /// 저장된 토큰으로 세션을 복원한다. 토큰이 없으면 Success(null).
  Future<Result<AuthUser?>> restoreSession();
}
