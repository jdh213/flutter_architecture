import 'package:flutter/material.dart';

/// Material ColorScheme이 커버하지 못하는 시맨틱 색상 토큰.
///
/// ThemeExtension이므로 위젯에서는 `context.semanticColors.warning`처럼
/// 테마를 통해 접근한다 — 라이트/다크가 자동으로 전환된다.
/// 브랜드 토큰이 생기면 이 값들을 디자이너 팔레트로 교체한다.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
  });

  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;

  static const AppSemanticColors light = AppSemanticColors(
    success: Color(0xFFC8E6C9),
    onSuccess: Color(0xFF1B5E20),
    warning: Color(0xFFFFECB3),
    onWarning: Color(0xFF5C4400),
    info: Color(0xFFBBDEFB),
    onInfo: Color(0xFF0D47A1),
  );

  static const AppSemanticColors dark = AppSemanticColors(
    success: Color(0xFF1E3B20),
    onSuccess: Color(0xFFA5D6A7),
    warning: Color(0xFF4A3B00),
    onWarning: Color(0xFFFFE082),
    info: Color(0xFF123A5C),
    onInfo: Color(0xFF90CAF9),
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  AppSemanticColors lerp(AppSemanticColors? other, double t) {
    if (other == null) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}

/// `Theme.of(context).extension<AppSemanticColors>()!`의 축약형.
extension AppSemanticColorsX on BuildContext {
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>()!;
}
