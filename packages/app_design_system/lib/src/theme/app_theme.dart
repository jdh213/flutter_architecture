import 'package:flutter/material.dart';

/// 앱 전역 테마. 프로젝트 시작 시 [_seedColor]만 브랜드 색상으로 바꾸면
/// Material 3 팔레트 전체가 파생된다.
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
