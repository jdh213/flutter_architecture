import 'package:app/src/app.dart';
import 'package:app_core/app_core.dart';
import 'package:app_network/app_network.dart';
import 'package:app_shell/app_shell.dart';
import 'package:feature_auth/feature_auth.dart';

/// 이 앱의 조립. flavor 진입점(main_dev.dart 등)이 [EnvConfig]를 주입하며 호출한다.
///
/// 공통 골격(바인딩, 컨테이너, 전역 에러 훅, runApp)은 app_shell의
/// [bootstrapApp]이 담당하고, 여기에는 **이 앱 고유의 조립**만 남는다.
/// 새 앱을 추가할 때는 이 파일과 같은 형태의 bootstrap을 그 앱에 만든다
/// (docs/manual/NEW_APP_GUIDE.md).
Future<void> bootstrap(EnvConfig env) => bootstrapApp(
  env: env,
  overrides: [
    // app_network ← feature_auth 연결 (의존성 역전).
    // 네트워크 계층은 인증 feature를 모르지만, 토큰 읽기와
    // 401 처리를 여기서 실제 구현으로 배선한다.
    tokenReaderProvider.overrideWith(
      (ref) =>
          () => ref.read(authTokenStoreProvider).readAccessToken(),
    ),
    authFailureHandlerProvider.overrideWith(
      (ref) =>
          () => ref.read(sessionControllerProvider.notifier).logout(),
    ),
  ],
  // 저장된 토큰으로 세션 복원 시도. 완료되면 AuthUnknown → 결과 상태로
  // 전이되고 라우터가 자동으로 로그인/홈을 분기한다.
  afterInit: (container) =>
      container.read(sessionControllerProvider.notifier).restore(),
  app: const App(),
);
