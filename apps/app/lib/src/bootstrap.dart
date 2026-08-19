import 'dart:async';

import 'package:app/src/app.dart';
import 'package:app_core/app_core.dart';
import 'package:app_network/app_network.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 앱 공통 부트스트랩. flavor 진입점(main_dev.dart 등)이 [EnvConfig]를
/// 주입하며 호출한다.
///
/// 여기가 이 템플릿의 **DI 배선 지점**이다. 하위 패키지가 열어둔
/// 의존성 역전 provider들을 실제 구현으로 연결한다.
Future<void> bootstrap(EnvConfig env) async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    overrides: [
      // 1. 환경 설정 주입 — 모든 패키지가 envConfigProvider로 읽는다.
      envConfigProvider.overrideWithValue(env),

      // 2. app_network ← feature_auth 연결 (의존성 역전).
      //    네트워크 계층은 인증 feature를 모르지만, 토큰 읽기와
      //    401 처리를 여기서 실제 구현으로 배선한다.
      tokenReaderProvider.overrideWith(
        (ref) =>
            () => ref.read(authTokenStoreProvider).readAccessToken(),
      ),
      authFailureHandlerProvider.overrideWith(
        (ref) =>
            () => ref.read(sessionControllerProvider.notifier).logout(),
      ),
    ],
  );

  // 저장된 토큰으로 세션 복원 시도. 완료되면 AuthUnknown → 결과 상태로
  // 전이되고 라우터가 자동으로 로그인/홈을 분기한다.
  unawaited(container.read(sessionControllerProvider.notifier).restore());

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
