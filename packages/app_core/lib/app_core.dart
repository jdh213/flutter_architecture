/// 순수 Dart 공통 계층.
///
/// 모든 패키지가 의존하는 최하위 계층으로, Flutter에 의존하지 않는다.
/// - `Result` : 성공/실패를 타입으로 표현하는 반환 규약
/// - `AppException` : 앱 전역 예외 체계 (sealed)
/// - `AppLogger` : 태그 기반 로거
/// - `EnvConfig` : flavor별 환경 설정 (bootstrap에서 override)
library;

export 'src/env/env_config.dart';
export 'src/error/app_exception.dart';
export 'src/error/error_reporter.dart';
export 'src/logger/app_logger.dart';
export 'src/result/result.dart';
