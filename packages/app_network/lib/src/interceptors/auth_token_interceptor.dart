import 'package:app_network/src/token_reader.dart';
import 'package:dio/dio.dart';

/// 모든 요청에 Bearer 토큰을 첨부하고, **토큰을 첨부했던 요청**이 401을
/// 받았을 때만 세션 만료 처리를 위임한다.
///
/// - 로그인처럼 토큰 없이 나간 요청의 401(자격증명 오답)은 세션 만료가
///   아니므로 전역 로그아웃을 트리거하지 않는다.
/// - 토큰 읽기 실패(secure storage 장애)는 "무토큰 진행"으로 강등한다 —
///   국소 장애가 모든 API 요청의 실패로 증폭되면 안 된다.
///
/// 토큰 갱신(refresh token rotation)이 필요한 프로젝트는 이 인터셉터의
/// onError에서 401 → refresh 시도 → 원 요청 재시도 로직을 구현한다.
/// (docs/manual/NEW_FEATURE_GUIDE.md의 '인증 확장' 절 참고)
class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor({
    required this._readToken,
    required this._onAuthFailure,
  });

  static const String _tokenAttachedKey = 'auth.token_attached';

  final TokenReader _readToken;
  final AuthFailureHandler _onAuthFailure;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token;
    try {
      token = await _readToken();
    } on Exception {
      // secure storage 장애 → 토큰 없이 진행 (요청 자체를 죽이지 않는다).
      token = null;
    }
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      options.extra[_tokenAttachedKey] = true;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final tokenWasAttached =
        err.requestOptions.extra[_tokenAttachedKey] == true;
    if (err.response?.statusCode == 401 && tokenWasAttached) {
      await _onAuthFailure();
    }
    handler.next(err);
  }
}
