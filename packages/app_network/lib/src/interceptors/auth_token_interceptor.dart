import 'package:app_network/src/token_reader.dart';
import 'package:dio/dio.dart';

/// 모든 요청에 Bearer 토큰을 첨부하고, 401 응답 시 세션 만료 처리를 위임한다.
///
/// 토큰 갱신(refresh token rotation)이 필요한 프로젝트는 이 인터셉터의
/// onError에서 401 → refresh 시도 → 원 요청 재시도 로직을 구현한다.
/// (docs/manual/NEW_FEATURE_GUIDE.md의 '인증 확장' 절 참고)
class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor({
    required this._readToken,
    required this._onAuthFailure,
  });

  final TokenReader _readToken;
  final AuthFailureHandler _onAuthFailure;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _readToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _onAuthFailure();
    }
    handler.next(err);
  }
}
