import 'dart:developer' as developer;

import 'package:app_core/src/env/env_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_logger.g.dart';

enum LogLevel { debug, info, warning, error }

/// 태그 기반 로거.
///
/// print() 를 직접 쓰지 않고 항상 이 로거를 사용한다.
/// prod flavor에서는 debug/info 레벨이 자동으로 걸러진다.
class AppLogger {
  const AppLogger({required this.minLevel});

  final LogLevel minLevel;

  void d(String tag, String message) => _log(LogLevel.debug, tag, message);

  void i(String tag, String message) => _log(LogLevel.info, tag, message);

  void w(String tag, String message, [Object? error, StackTrace? st]) =>
      _log(LogLevel.warning, tag, message, error, st);

  void e(String tag, String message, [Object? error, StackTrace? st]) =>
      _log(LogLevel.error, tag, message, error, st);

  void _log(
    LogLevel level,
    String tag,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (level.index < minLevel.index) return;
    developer.log(
      message,
      name: tag,
      level: switch (level) {
        LogLevel.debug => 500,
        LogLevel.info => 800,
        LogLevel.warning => 900,
        LogLevel.error => 1000,
      },
      error: error,
      stackTrace: stackTrace,
    );
  }
}

@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) {
  final env = ref.watch(envConfigProvider);
  return AppLogger(
    minLevel: env.isProd ? LogLevel.warning : LogLevel.debug,
  );
}
