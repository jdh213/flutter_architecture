import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';

/// [DioException]을 앱 전역 예외 체계인 [NetworkException]으로 변환한다.
///
/// 이 계층의 책임은 실패의 **분류**([NetworkErrorType])까지다.
/// message는 개발자용(로그) 설명이며, 사용자 노출 문구는 presentation에서
/// app_l10n의 `localizedMessage(l10n)`가 type을 보고 만든다.
/// 원본 예외는 [AppException.cause]에 보존되어 로깅에 사용된다.
NetworkException mapDioException(DioException e, [StackTrace? stackTrace]) {
  final statusCode = e.response?.statusCode;

  final (type, message) = switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => (
      NetworkErrorType.timeout,
      'Request timed out',
    ),
    DioExceptionType.connectionError => (
      NetworkErrorType.noConnection,
      'No network connection',
    ),
    DioExceptionType.cancel => (
      NetworkErrorType.cancelled,
      'Request cancelled',
    ),
    DioExceptionType.badResponse => switch (statusCode) {
      401 => (NetworkErrorType.unauthorized, 'Unauthorized (401)'),
      403 => (NetworkErrorType.forbidden, 'Forbidden (403)'),
      404 => (NetworkErrorType.notFound, 'Not found (404)'),
      != null && >= 500 => (
        NetworkErrorType.server,
        'Server error ($statusCode)',
      ),
      _ => (NetworkErrorType.unknown, 'Unexpected response ($statusCode)'),
    },
    DioExceptionType.badCertificate ||
    DioExceptionType.unknown => (NetworkErrorType.unknown, 'Network error'),
  };

  return NetworkException(
    message: message,
    type: type,
    statusCode: statusCode,
    cause: e,
    stackTrace: stackTrace ?? e.stackTrace,
  );
}
