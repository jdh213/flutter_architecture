/// 디자인 시스템.
///
/// - tokens  : 색상 시드, 간격, 라운드 등 디자인 토큰. 위젯에서 리터럴 숫자/색상
///             하드코딩을 금지하고 항상 토큰을 참조한다.
/// - theme   : Material 3 라이트/다크 테마
/// - widgets : 공용 위젯. 두 개 이상의 feature에서 쓰이는 위젯만 여기로 승격한다.
///
/// 이 패키지는 비즈니스 로직(다른 app_*, feature_*)에 의존하지 않는다.
library;

export 'src/theme/app_theme.dart';
export 'src/tokens/app_radius.dart';
export 'src/tokens/app_semantic_colors.dart';
export 'src/tokens/app_spacing.dart';
export 'src/widgets/app_button.dart';
export 'src/widgets/app_error_view.dart';
export 'src/widgets/app_gap.dart';
export 'src/widgets/app_loading_view.dart';
export 'src/widgets/app_text_field.dart';
