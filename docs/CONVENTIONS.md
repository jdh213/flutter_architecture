# 코딩 컨벤션

## 네이밍

| 대상 | 규칙 | 예 |
|---|---|---|
| 패키지 | 공통 인프라 `app_*`, 기능 `feature_*` | `app_network`, `feature_auth` |
| 화면 | `XxxScreen` + `static const routePath` | `PostListScreen` |
| ViewModel | `XxxViewModel` (Riverpod Notifier) | `PostListViewModel` |
| Intent | `Xxx` + 과거형 동사/이벤트명 | `LoginSubmitted`, `PostListRefreshed` |
| Effect | `Xxx` + 동작명 | `LoginShowError`, `PostListNavigateToDetail` |
| Repository | 인터페이스 `XxxRepository`, 구현 `XxxRepositoryImpl` | |
| DTO | `XxxDto` (data 전용) ↔ 엔티티 `Xxx` (domain) | `PostDto` / `Post` |
| Provider | 카멜케이스 + `Provider` (codegen 자동) | `postsRepositoryProvider` |

## 폴더 & 파일

- 화면 하나 = `presentation/<화면명>/` 아래 MVI 5파일
  (`_screen`, `_view_model`, `_state`, `_intent`, `_effect`; effect 없으면 생략).
- feature 내부는 `domain / data / presentation` 3분할 + 구분 폴더:
  domain은 `entities/ repositories/ usecases/`, data는
  `datasources/ dtos/ repositories/` (ARCHITECTURE.md 2절의 트리 참고).
- 두 개 이상의 feature가 쓰는 위젯만 `app_design_system`으로 승격한다.

## Import 규칙

- 다른 패키지는 **barrel만** import: `package:feature_auth/feature_auth.dart` (O),
  `package:feature_auth/src/...` (X). 단, 같은 패키지 안의 테스트는 src 접근 허용.
- feature 간 직접 import 금지. 연결은 apps/app이 조립한다
  (예: `LogoutButton`을 `PostListScreen.appBarActions`로 주입).
- `app_core`에는 Flutter import 금지 (순수 Dart 유지).

## 상태관리 / DI

- provider는 전부 `@riverpod` codegen. 수동 `Provider(...)` 생성 금지.
- provider 위치 (ADR-0005): 경계 provider(Repository/UseCase)는 feature의
  `src/di.dart`, data 내부 전용(API 클라이언트 등)은 구현 파일 옆.
  presentation은 data 파일을 직접 import 하지 않는다.
- 인프라성 provider(네트워크, 저장소, Repository)는 `@Riverpod(keepAlive: true)`,
  화면 ViewModel은 기본(autoDispose).
- ViewModel 밖에서 `ref.read`로 다른 Notifier의 메서드 호출은
  composition root(앱) 또는 ViewModel 내부에서만.
- View에서는 `ref.watch(provider)` + `ref.read(provider.notifier)` 조합만 사용.

## 비동기

- Repository는 `Result<T>` 반환. UI 계층까지 예외를 던지지 않는다.
- `await` 후 상태를 만지는 ViewModel 코드는 `if (!ref.mounted) return;` 필수.
- 의도적으로 기다리지 않는 Future는 `unawaited(...)`로 감싼다 (lint 강제).

## 코드 생성물 (.g.dart / .freezed.dart)

- **커밋한다.** 템플릿 복사 직후 빌드 없이 바로 실행 가능해야 하기 때문.
- 재생성: `./scripts/gen.sh` 또는 패키지에서 `dart run build_runner watch`.
- 리뷰 시 생성 파일 diff는 무시한다 (분석/포맷 검사에서도 제외됨).

## Lint

- 루트 `analysis_options.yaml` 하나로 전체 적용 (very_good_analysis + riverpod_lint).
- 패키지에 개별 analysis_options.yaml을 만들지 않는다 (루트 설정이 무시됨).
- `// ignore:`는 반드시 바로 위에 이유 주석과 함께.

## 문자열 / 국제화 (l10n)

- 사용자 노출 문자열은 위젯/상태/예외에 하드코딩하지 않는다.
  `packages/app_l10n/lib/l10n/*.arb`(ko 템플릿 + en)에 키를 추가하고
  위젯에서 `context.l10n.키`로 읽는다. 재생성은 `./scripts/gen.sh`.
- State/Effect에는 문구가 아니라 `AppException`을 담고, View가
  `exception.localizedMessage(context.l10n)`로 변환한다.
- `AppException.message`는 개발자용(로그) — 영문 기술 설명으로 쓴다.
- 로그·주석·문서는 자유 (l10n 대상 아님).

## 비밀값 (API 키 등)

- 코드/JSON에 하드코딩 금지. `env/*.local.json`(gitignore 대상)에 넣고
  `--dart-define-from-file`로 주입 → `String.fromEnvironment`로 읽는다.
- 토큰 등 런타임 민감 정보는 반드시 `SecureStore`에 저장 (KeyValueStore 금지).
- 자세한 절차: [manual/FLAVORS_AND_ENV.md](manual/FLAVORS_AND_ENV.md)

## 테스트

- ViewModel: `ProviderContainer(overrides: [...])` + mocktail로 Repository mock.
  autoDispose provider는 `container.listen(...)`으로 구독을 유지한 채 테스트.
- Repository: API만 mock, 캐시는 in-memory drift(`NativeDatabase.memory()`) 실물 사용.
- 위젯: 공용 위젯(design system) 단위로 작성.
- 각 패키지 `test/`에 위치. 전체 실행은 `./scripts/test.sh`.
- E2E: `apps/app/integration_test/` — 실기기/에뮬레이터에서
  `flutter test integration_test --flavor dev`로 실행 (CI 미포함, 파일 주석 참고).
- golden 테스트는 기본 포함하지 않는다 — 플랫폼별 폰트 렌더링 차이로 CI가
  불안정해지기 때문. 도입하려면 alchemist 등 CI-safe 도구와 함께 추가한다.
