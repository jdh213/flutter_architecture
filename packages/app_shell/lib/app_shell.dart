/// 앱 조립의 공통 골격.
///
/// apps/ 아래 모든 앱은 `bootstrapApp` 위에 자신의 조립만 얹는다:
/// - overrides : 그 앱의 DI 배선 (의존성 역전 provider 연결)
/// - afterInit : 첫 프레임 전 시작 작업 (세션 복원 등, 기다리지 않음)
/// - app       : 그 앱의 루트 위젯 (라우터 포함)
///
/// **라우터는 이 패키지에 두지 않는다** — 라우팅 그래프는 앱마다 다른
/// 조립 정보이므로 각 앱이 소유한다. (ADR-0007)
/// 이 패키지는 feature를 일절 모르며(app_core만 의존), 그래서 어떤 앱
/// 조합에서도 재사용된다.
library;

export 'src/bootstrap_app.dart';
