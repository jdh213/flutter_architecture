import 'package:app_mvi/app_mvi.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// 로그인 화면의 단일 불변 상태.
@freezed
abstract class LoginState with _$LoginState implements MviState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isSubmitting,
  }) = _LoginState;

  const LoginState._();

  bool get canSubmit =>
      email.isNotEmpty && password.isNotEmpty && !isSubmitting;
}
