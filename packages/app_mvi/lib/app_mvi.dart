/// MVI(Model-View-Intent) 프레젠테이션 기반 계층.
///
/// 모든 feature의 화면은 다음 5파일 구조를 따른다:
///
/// ```text
/// presentation/screens/login/
/// ├── login_screen.dart      # View — state 구독 + intent 전달만 한다
/// ├── login_view_model.dart  # Riverpod Notifier — intent를 받아 state/effect를 방출
/// ├── login_state.dart       # 단일 불변 상태 (freezed, MviState 구현)
/// ├── login_intent.dart      # 사용자 의도 (sealed, MviIntent 구현)
/// └── login_effect.dart      # 일회성 이벤트 (sealed, MviEffect 구현)
/// ```
///
/// 데이터 흐름 (단방향):
///
/// ```text
///        Intent                 State
/// View ─────────▶ ViewModel ─────────▶ View
///                     │
///                     └────── Effect ──▶ (스낵바 / 네비게이션 등 1회성)
/// ```
///
/// 규칙:
/// 1. View는 ViewModel의 임의 메서드를 호출하지 않는다. 오직 `onIntent(...)`.
/// 2. State는 화면을 그리는 데 필요한 모든 것을 담은 단일 불변 객체다.
/// 3. 스낵바·다이얼로그·네비게이션처럼 "한 번만 소비되는" 것은 State가 아니라
///    Effect로 방출한다. State에 담으면 rebuild마다 재실행되는 버그가 생긴다.
library;

export 'src/mvi_contracts.dart';
export 'src/mvi_effect_emitter.dart';
export 'src/mvi_effect_listener.dart';
