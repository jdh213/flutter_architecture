import 'package:app_design_system/src/tokens/app_spacing.dart';
import 'package:flutter/widgets.dart';

/// 간격 토큰 기반의 빈 공간. Row/Column 양쪽에서 동일하게 동작한다.
class AppGap extends StatelessWidget {
  const AppGap.xs({super.key}) : _size = AppSpacing.xs;

  const AppGap.sm({super.key}) : _size = AppSpacing.sm;

  const AppGap.md({super.key}) : _size = AppSpacing.md;

  const AppGap.lg({super.key}) : _size = AppSpacing.lg;

  const AppGap.xl({super.key}) : _size = AppSpacing.xl;

  final double _size;

  @override
  Widget build(BuildContext context) => SizedBox.square(dimension: _size);
}
