/// 인증 feature.
///
/// 외부(앱)에 노출하는 public API:
/// - `sessionControllerProvider` : 전역 인증 상태. 라우터 redirect가 구독한다.
/// - `AuthStatus` 계층 : Unknown / Authenticated / Unauthenticated
/// - `LoginScreen` : 로그인 화면
/// - `authTokenStoreProvider` : 앱이 app_network의 tokenReaderProvider를
///   override 할 때 사용한다.
///
/// src/ 내부 구조는 barrel에서 노출하지 않는 한 다른 패키지에서 import 금지.
library;

export 'src/data/auth_token_store.dart' show authTokenStoreProvider;
export 'src/domain/auth_status.dart';
export 'src/domain/auth_user.dart';
export 'src/presentation/login/login_screen.dart';
export 'src/presentation/session/session_controller.dart';
