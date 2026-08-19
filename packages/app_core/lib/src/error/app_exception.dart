/// 앱 전역 예외 체계.
///
/// 모든 계층은 실패를 [AppException]의 하위 타입으로 변환해 전달한다.
/// sealed 클래스이므로 switch 문에서 모든 실패 유형의 처리가 컴파일 타임에 강제된다.
///
/// 계층별 변환 책임:
/// - app_network : DioException → [NetworkException]
/// - app_storage : 저장소 오류 → [CacheException]
/// - feature/*   : 도메인 검증 실패 → [ValidationException]
sealed class AppException implements Exception {
  const AppException({
    required this.message,
    this.cause,
    this.stackTrace,
  });

  /// 사용자에게 그대로 노출해도 되는 수준의 메시지.
  final String message;

  /// 원본 예외. 로깅용으로만 사용하고 UI에 노출하지 않는다.
  final Object? cause;

  final StackTrace? stackTrace;
}

/// 네트워크 실패 유형. HTTP 상태 코드보다 한 단계 추상화된 분류를 사용한다.
enum NetworkErrorType {
  /// 인터넷 연결 없음 / DNS 실패
  noConnection,

  /// 연결·송신·수신 타임아웃
  timeout,

  /// 401 — 세션 만료. 전역 로그아웃 처리의 트리거가 된다.
  unauthorized,

  /// 403
  forbidden,

  /// 404
  notFound,

  /// 5xx
  server,

  /// 요청이 명시적으로 취소됨
  cancelled,

  unknown,
}

final class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    required this.type,
    this.statusCode,
    super.cause,
    super.stackTrace,
  });

  final NetworkErrorType type;
  final int? statusCode;

  @override
  String toString() =>
      'NetworkException($type, status: $statusCode, message: $message, '
      'cause: $cause)';
}

/// 로컬 저장소(DB, prefs, secure storage) 실패.
final class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() => 'CacheException(message: $message, cause: $cause)';
}

/// 도메인 규칙 위반 (입력값 검증 실패 등).
final class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() => 'ValidationException(message: $message, cause: $cause)';
}

/// 분류되지 않은 실패. `Result.guard`가 마지막에 감싸는 타입.
final class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() => 'UnknownException(message: $message, cause: $cause)';
}
