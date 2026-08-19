import 'package:app_design_system/src/tokens/app_semantic_colors.dart';
import 'package:flutter/material.dart';

/// 앱 전역 테마. 프로젝트 시작 시 [_seedColor]만 브랜드 색상으로 바꾸면
/// Material 3 팔레트 전체가 파생된다.
///
/// 타이포그래피는 Material 3 textTheme을 토큰으로 사용한다
/// (`Theme.of(context).textTheme.*`). 브랜드 폰트 도입 시 이 파일에서
/// `fontFamily`와 textTheme 오버라이드를 추가한다.
abstract final class AppTheme {
  static const Color _seedColor = Color(0xFF3D5AFE);

  static ThemeData get light => _base(Brightness.light);

  static ThemeData get dark => _base(Brightness.dark);

  static ThemeData _base(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: [
        if (brightness == Brightness.light)
          AppSemanticColors.light
        else
          AppSemanticColors.dark,
      ],
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
