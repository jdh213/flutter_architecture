import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:app_mvi/app_mvi.dart';
import 'package:feature_auth/src/di.dart';
import 'package:feature_auth/src/presentation/login/login_effect.dart';
import 'package:feature_auth/src/presentation/login/login_intent.dart';
import 'package:feature_auth/src/presentation/login/login_state.dart';
import 'package:feature_auth/src/presentation/session/session_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel
    with MviEffectEmitter<LoginEffect> {
  @override
  LoginState build() {
    ref.onDispose(disposeEffects);
    return const LoginState();
  }

  /// View가 호출하는 유일한 진입점.
  void onIntent(LoginIntent intent) {
    switch (intent) {
      case LoginEmailChanged(:final email):
        state = state.copyWith(email: email);
      case LoginPasswordChanged(:final password):
        state = state.copyWith(password: password);
      case LoginSubmitted():
        unawaited(_submit());
    }
  }

  Future<void> _submit() async {
    if (!state.canSubmit) return;
    state = state.copyWith(isSubmitting: true);

    final result = await ref
        .read(authRepositoryProvider)
        .login(
          email: state.email,
          password: state.password,
        );

    // await 이후에는 화면 이탈로 provider가 dispose 됐을 수 있다.
    if (!ref.mounted) return;

    switch (result) {
      case Success(:final value):
        // 상태만 변경한다. 화면 전환은 라우터 redirect가 담당한다.
        ref.read(sessionControllerProvider.notifier).onLoggedIn(value);
      case Failure(:final exception):
        state = state.copyWith(isSubmitting: false);
        emitEffect(LoginShowError(exception));
    }
  }
}
