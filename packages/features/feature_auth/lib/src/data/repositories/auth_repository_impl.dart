import 'package:app_core/app_core.dart';
import 'package:app_network/app_network.dart';
import 'package:feature_auth/src/data/datasources/auth_api.dart';
import 'package:feature_auth/src/data/datasources/auth_token_store.dart';
import 'package:feature_auth/src/domain/entities/auth_user.dart';
import 'package:feature_auth/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this._api,
    required this._tokenStore,
  });

  final AuthApi _api;
  final AuthTokenStore _tokenStore;

  @override
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  }) => safeApiCall(() async {
    final session = await _api.login(email: email, password: password);
    await _tokenStore.saveAccessToken(session.accessToken);
    return session.user;
  });

  @override
  Future<Result<void>> logout() => Result.guard(_tokenStore.clear);

  @override
  Future<Result<AuthUser?>> restoreSession() => safeApiCall(() async {
    final token = await _tokenStore.readAccessToken();
    if (token == null) return null;
    return _api.me();
  });

  // 인증 확장 지점:
  // - 리프레시 토큰: AuthTokenStore에 refresh 토큰 저장을 추가하고
  //   app_network의 AuthTokenInterceptor.onError에서 갱신 후 재시도한다.
  // - 소셜 로그인: AuthApi에 loginWithKakao() 등을 추가하고
  //   구현체만 교체한다. 이 파일과 presentation은 변경되지 않는다.
}
