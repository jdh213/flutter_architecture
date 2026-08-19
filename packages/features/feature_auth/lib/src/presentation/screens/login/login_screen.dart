import 'package:app_design_system/app_design_system.dart';
import 'package:app_l10n/app_l10n.dart';
import 'package:app_mvi/app_mvi.dart';
import 'package:feature_auth/src/presentation/screens/login/login_effect.dart';
import 'package:feature_auth/src/presentation/screens/login/login_intent.dart';
import 'package:feature_auth/src/presentation/screens/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 로그인 화면 (View).
///
/// MVI 규칙에 따라 이 위젯은 다음 두 가지만 한다:
/// 1. state를 watch 하여 렌더링
/// 2. 사용자 입력을 Intent로 변환해 `onIntent(...)` 호출
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const String routePath = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final l10n = context.l10n;

    return MviEffectListener<LoginEffect>(
      effects: viewModel.effects,
      onEffect: (context, effect) {
        switch (effect) {
          case LoginShowError(:final exception):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(exception.localizedMessage(l10n))),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.loginTitle)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  label: l10n.emailLabel,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) =>
                      viewModel.onIntent(LoginEmailChanged(value)),
                ),
                const AppGap.lg(),
                AppTextField(
                  label: l10n.passwordLabel,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) =>
                      viewModel.onIntent(LoginPasswordChanged(value)),
                ),
                const AppGap.xl(),
                AppButton(
                  label: l10n.loginButton,
                  isLoading: state.isSubmitting,
                  onPressed: state.canSubmit
                      ? () => viewModel.onIntent(const LoginSubmitted())
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
