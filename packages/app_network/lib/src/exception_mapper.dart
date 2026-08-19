import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';

/// [DioException]을 앱 전역 예외 체계인 [NetworkException]으로 변환한다.
///
/// message는 사용자에게 그대로 노출 가능한 한국어 문구로 통일한다.
/// 원본 예외는 [AppException.cause]에 보존되어 로깅에 사용된다.
NetworkException mapDioException(DioException e, [StackTrace? stackTrace]) {
  final statusCode = e.response?.statusCode;

  final (type, message) = switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => (
      NetworkErrorType.timeout,
      '요청 시간이 초과되었습니다. 잠시 후 다시 시도해주세요.',
    ),
    DioExceptionType.connectionError => (
      NetworkErrorType.noConnection,
      '네트워크 연결을 확인해주세요.',
    ),
    DioExceptionType.cancel => (NetworkErrorType.cancelled, '요청이 취소되었습니다.'),
    DioExceptionType.badResponse => switch (statusCode) {
      401 => (NetworkErrorType.unauthorized, '로그인이 만료되었습니다. 다시 로그인해주세요.'),
      403 => (NetworkErrorType.forbidden, '접근 권한이 없습니다.'),
      404 => (NetworkErrorType.notFound, '요청한 정보를 찾을 수 없습니다.'),
      != null && >= 500 => (
        NetworkErrorType.server,
        '서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ),
      _ => (NetworkErrorType.unknown, '요청 처리 중 오류가 발생했습니다.'),
    },
    DioExceptionType.badCertificate ||
    DioExceptionType.unknown => (NetworkErrorType.unknown, '네트워크 오류가 발생했습니다.'),
  };

  return NetworkException(
    message: message,
    type: type,
    statusCode: statusCode,
    cause: e,
    stackTrace: stackTrace ?? e.stackTrace,
  );
}
