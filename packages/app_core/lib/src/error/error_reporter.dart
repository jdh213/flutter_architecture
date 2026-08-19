import 'package:app_core/src/logger/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_reporter.g.dart';

/// 잡히지 않은 에러의 최종 수신처.
///
/// bootstrap이 FlutterError.onError / PlatformDispatcher.onError를 여기로
/// 연결한다. 크래시 리포팅 도구(Sentry, Crashlytics 등)를 붙일 때는
/// 이 인터페이스의 구현체를 만들고 bootstrap의 overrides에서 교체한다 —
/// 앱 코드는 변경되지 않는다.
// 크래시 리포팅 구현 교체(Sentry 등)를 위한 의도적인 단일 메서드 인터페이스.
// ignore: one_member_abstracts
abstract interface class ErrorReporter {
  Future<void> report(
    Object error,
    StackTrace stackTrace, {
    bool fatal = false,
  });
}

/// 기본 구현: 로거로만 남긴다. 외부 전송 없음.
class LoggingErrorReporter implements ErrorReporter {
  const LoggingErrorReporter(this._logger);

  final AppLogger _logger;

  @override
  Future<void> report(
    Object error,
    StackTrace stackTrace, {
    bool fatal = false,
  }) async {
    _logger.e(
      'ErrorReporter',
      fatal ? '잡히지 않은 치명적 에러' : '잡히지 않은 에러',
      error,
      stackTrace,
    );
  }
}

@Riverpod(keepAlive: true)
ErrorReporter errorReporter(Ref ref) =>
    LoggingErrorReporter(ref.watch(appLoggerProvider));
