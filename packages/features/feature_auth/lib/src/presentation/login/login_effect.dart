import 'package:app_mvi/app_mvi.dart';

/// 로그인 화면의 일회성 이벤트.
///
/// 로그인 성공은 Effect가 아니다 — SessionController의 상태 변경에
/// 라우터 redirect가 반응해 자동으로 화면이 전환된다.
sealed class LoginEffect implements MviEffect {
  const LoginEffect();
}

final class LoginShowError extends LoginEffect {
  const LoginShowError(this.message);

  final String message;
}
