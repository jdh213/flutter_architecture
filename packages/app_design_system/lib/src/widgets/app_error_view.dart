import 'package:app_design_system/src/tokens/app_spacing.dart';
import 'package:app_design_system/src/widgets/app_button.dart';
import 'package:app_design_system/src/widgets/app_gap.dart';
import 'package:flutter/material.dart';

/// 화면 전체 에러 표시 + 재시도 버튼.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    required this.message,
    this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const AppGap.md(),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const AppGap.lg(),
              AppButton(
                label: '다시 시도',
                variant: AppButtonVariant.secondary,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
