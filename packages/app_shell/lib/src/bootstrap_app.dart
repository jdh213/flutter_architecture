import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Override 타입은 riverpod 3에서 flutter_riverpod barrel에 노출되지 않고
// riverpod_annotation을 통해 노출된다.
import 'package:riverpod_annotation/riverpod_annotation.dart' show Override;

/// 모든 앱이 공유하는 부트스트랩 골격.
///
/// 하는 일 (앱과 무관하게 항상 동일):
/// 1. 바인딩 초기화
/// 2. [EnvConfig] 주입 + 앱별 [overrides]로 ProviderContainer 구성
/// 3. 잡히지 않은 에러를 [ErrorReporter]로 배선
///    (FlutterError.onError + PlatformDispatcher.onError)
/// 4. [afterInit] 실행 후(기다리지 않음) runApp
///
/// 앱별로 다른 것(라우터, DI 배선, 시작 작업)은 전부 파라미터로 받는다.
/// 사용 예는 apps/app/lib/src/bootstrap.dart 참고.
Future<void> bootstrapApp({
  required EnvConfig env,
  required Widget app,
  List<Override> overrides = const [],
  Future<void> Function(ProviderContainer container)? afterInit,
}) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    overrides: [
      envConfigProvider.overrideWith((ref) => env),
      ...overrides,
    ],
  );

  // 크래시 리포팅 도구(Sentry/Crashlytics 등)를 붙일 때는
  // errorReporterProvider를 override 하면 된다 — 이 훅은 그대로 유지된다.
  final reporter = container.read(errorReporterProvider);
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    unawaited(
      reporter.report(details.exception, details.stack ?? StackTrace.current),
    );
  };
  binding.platformDispatcher.onError = (error, stackTrace) {
    // true를 반환해 에러를 소비하므로, release 빌드에서도 최소한의 흔적이
    // 남도록 콘솔 덤프를 강제한다 (기본 reporter의 developer.log는
    // release/AOT에서 no-op이다). 크래시 리포터 도입 후에도 무해하다.
    FlutterError.dumpErrorToConsole(
      FlutterErrorDetails(exception: error, stack: stackTrace),
      forceReport: true,
    );
    unawaited(reporter.report(error, stackTrace, fatal: true));
    return true;
  };

  if (afterInit != null) {
    unawaited(afterInit(container));
  }

  runApp(UncontrolledProviderScope(container: container, child: app));
}
