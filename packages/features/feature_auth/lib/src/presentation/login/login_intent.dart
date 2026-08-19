import 'package:app_mvi/app_mvi.dart';

/// 로그인 화면에서 발생 가능한 모든 사용자 의도.
sealed class LoginIntent implements MviIntent {
  const LoginIntent();
}

final class LoginEmailChanged extends LoginIntent {
  const LoginEmailChanged(this.email);

  final String email;
}

final class LoginPasswordChanged extends LoginIntent {
  const LoginPasswordChanged(this.password);

  final String password;
}

final class LoginSubmitted extends LoginIntent {
  const LoginSubmitted();
}
