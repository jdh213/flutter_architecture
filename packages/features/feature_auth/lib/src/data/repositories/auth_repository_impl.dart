import 'package:app_core/app_core.dart';
import 'package:app_network/app_network.dart';
import 'package:dio/dio.dart';
import 'package:feature_auth/src/data/datasources/local/auth_token_store.dart';
import 'package:feature_auth/src/data/datasources/remote/auth_api.dart';
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
    await _saveUserOrIgnore(session.user);
    return session.user;
  });

  @override
  Future<Result<void>> logout() => Result.guard(_tokenStore.clear);

  /// 세션 복원 정책:
  /// - 토큰 없음            → Success(null) — 로그인 화면으로
  /// - me() 성공            → Success(user) + 프로필 스냅샷 갱신
  /// - me() 401             → 토큰 무효 확정. 세션 폐기 후 Success(null)
  /// - me() 일시 장애(오프라인 등) → 저장된 프로필 스냅샷으로 오프라인 진입.
  ///   스냅샷도 없으면(최초 실행) 실패 전파. 토큰 유효성은 이후 요청의
  ///   401 전역 처리(AuthTokenInterceptor)가 재검증한다.
  @override
  Future<Result<AuthUser?>> restoreSession() => safeApiCall(() async {
    final token = await _tokenStore.readAccessToken();
    if (token == null) return null;

    try {
      final user = await _api.me();
      await _saveUserOrIgnore(user);
      return user;
    } on DioException catch (e) {
      if (mapDioException(e).type == NetworkErrorType.unauthorized) {
        await _tokenStore.clear();
        return null;
      }
      final cachedUser = await _tokenStore.readUser();
      if (cachedUser != null) return cachedUser;
      rethrow;
    }
  });

  /// 프로필 스냅샷은 부가 기능 — 저장 실패가 로그인/복원을 망치면 안 된다.
  Future<void> _saveUserOrIgnore(AuthUser user) async {
    try {
      await _tokenStore.saveUser(user);
    } on Exception {
      // 무시 — 다음 성공 시 다시 저장된다.
    }
  }

  // 인증 확장 지점:
  // - 리프레시 토큰: AuthTokenStore에 refresh 토큰 저장을 추가하고
  //   app_network의 AuthTokenInterceptor.onError에서 갱신 후 재시도한다.
  // - 소셜 로그인: AuthApi에 loginWithKakao() 등을 추가하고
  //   구현체만 교체한다. 이 파일과 presentation은 변경되지 않는다.
}
