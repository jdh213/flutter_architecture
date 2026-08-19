/// 사용자 의도. 화면당 하나의 sealed 클래스로 정의한다.
///
/// ```dart
/// sealed class LoginIntent implements MviIntent {
///   const LoginIntent();
/// }
///
/// final class LoginEmailChanged extends LoginIntent {
///   const LoginEmailChanged(this.email);
///   final String email;
/// }
///
/// final class LoginSubmitted extends LoginIntent {
///   const LoginSubmitted();
/// }
/// ```
abstract interface class MviIntent {}

/// 화면 상태. 화면당 하나의 불변(freezed) 클래스로 정의한다.
///
/// 로딩/에러/데이터를 별도 상태 클래스로 쪼개지 않고,
/// 하나의 State 안에 필드로 표현하는 것을 기본으로 한다.
abstract interface class MviState {}

/// 일회성 이벤트 (스낵바, 다이얼로그, 화면 이동 트리거 등).
///
/// State와 달리 구독자에게 정확히 한 번 전달되고 사라진다.
abstract interface class MviEffect {}
