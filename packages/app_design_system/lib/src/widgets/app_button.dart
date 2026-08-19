import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary }

/// 표준 버튼. [isLoading]이 true면 스피너를 표시하고 입력을 차단한다.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    super.key,
  });

  final String label;

  /// null이면 비활성화 상태로 렌더링된다.
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);
    final effectiveOnPressed = isLoading ? null : onPressed;

    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
    };
  }
}
