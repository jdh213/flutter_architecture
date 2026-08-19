# ADR-0003: 프레젠테이션 계층에 MVI 패턴 채택

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

Riverpod Notifier를 그대로 쓰면 화면마다 public 메서드가 자유롭게 늘어나
View → ViewModel 호출 표면이 제각각이 된다. 단방향 데이터 흐름과
일관된 화면 구조를 강제하기 위해 MVI(Model-View-Intent)를 도입한다.
(Android의 Orbit MVI / MVI 아키텍처와 같은 멘탈 모델)

## 결정

Riverpod 위에 MVI 계약을 얹는다 (`app_mvi` 패키지):

| MVI 요소 | 구현 |
|---|---|
| Intent | 화면당 sealed class (`MviIntent` 구현) |
| Model(State) | freezed 단일 불변 객체 (`MviState` 구현) |
| View | ConsumerWidget — state watch + `onIntent(...)` 호출만 |
| 처리기 | Riverpod Notifier (`XxxViewModel`) — 유일한 진입점 `onIntent` |
| Side Effect | sealed class (`MviEffect`) + `MviEffectEmitter` mixin + `MviEffectListener` 위젯 |

핵심 규칙:

1. **View는 `onIntent(...)`만 호출한다.** 임의 메서드 호출 금지 →
   화면의 모든 동작이 Intent 정의 파일 하나에 열거된다.
2. **State와 Effect의 구분**: 화면에 "계속 표시되는 것"은 State,
   "한 번만 소비되는 것"(스낵바/다이얼로그/네비게이션)은 Effect.
   Effect를 State에 넣으면 rebuild마다 재실행되는 고전적 버그가 생긴다.
3. 전역 상태(인증 세션 등)는 화면 MVI가 아니라 keepAlive Notifier
   (예: `SessionController`). 라우터가 이를 구독해 자동 분기한다.

## 기각된 대안

- **자유형 Notifier (메서드 여러 개)**: 관례가 강제되지 않아 화면마다 구조가 달라진다.
- **AsyncNotifier<T> 기반 (AsyncValue 상태)**: 로딩/에러 표현은 공짜지만
  refresh 중 데이터 유지, 오프라인 배너 같은 복합 상태 표현이 어색해진다.
  단일 freezed State가 화면 요구사항을 더 정직하게 표현한다.

## 트레이드오프 (감수한 것)

- 화면당 파일 5개로 보일러플레이트가 늘어난다
  → 대신 어떤 화면이든 구조가 같아져 탐색/리뷰 비용이 준다.
- `RefreshIndicator`처럼 Future 완료를 요구하는 프레임워크 API와
  fire-and-forget Intent가 어울리지 않는 경우가 있다
  → `isRefreshing` 같은 상태 필드로 표현하는 것을 기본으로 한다.
