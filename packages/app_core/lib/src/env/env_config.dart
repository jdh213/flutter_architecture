import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env_config.g.dart';

enum AppFlavor { dev, stg, prod }

/// flavor별 환경 설정.
///
/// 값은 앱의 flavor 진입점(main_dev.dart 등)에서 상수로 정의하고
/// bootstrap에서 [envConfigProvider]를 override 하여 주입한다.
///
/// API 키 같은 비밀값은 여기에 하드코딩하지 않는다.
/// `--dart-define-from-file=env/dev.local.json` 으로 주입하고
/// `String.fromEnvironment` 로 읽는다. (docs/ARCHITECTURE.md 참고)
class EnvConfig {
  const EnvConfig({
    required this.flavor,
    required this.apiBaseUrl,
    this.enableNetworkLog = false,
  }) : assert(
         !(flavor == AppFlavor.prod && enableNetworkLog),
         'prod에서는 enableNetworkLog를 켤 수 없다 (토큰/자격증명 로그 유출 방지)',
       );

  final AppFlavor flavor;
  final String apiBaseUrl;

  /// 네트워크 요청/응답 로그 출력 여부. prod에서는 반드시 false.
  final bool enableNetworkLog;

  bool get isProd => flavor == AppFlavor.prod;
}

/// 환경 설정 provider.
///
/// 기본 구현은 의도적으로 throw 한다 — 앱이 bootstrap에서 반드시
/// override 해야 함을 컴파일이 아닌 첫 접근 시점에 명확한 메시지로 알린다.
/// 이것이 이 템플릿의 표준 DI 패턴이다. (Hilt의 @Provides 모듈을
/// 앱 모듈에서 갈아끼우는 것과 같은 역할)
@Riverpod(keepAlive: true)
EnvConfig envConfig(Ref ref) {
  throw UnimplementedError(
    'envConfigProvider는 bootstrap()의 ProviderScope.overrides에서 주입해야 합니다.',
  );
}
