# Flutter Architecture Template — 개발 지침

멀티 패키지(pub workspace) + Riverpod 3(상태관리 & DI) + MVI 템플릿.
상세 설계는 docs/ARCHITECTURE.md, 규칙은 docs/CONVENTIONS.md 참고.

## 절대 규칙

1. **의존 방향**: app → feature_* → app_(network|storage|mvi|design_system|l10n) → app_core.
   역방향/feature 간 직접 import 금지. 연결은 apps/app(bootstrap overrides, 위젯 주입)이 조립.
   feature 내부에서 presentation은 data를 직접 import 하지 않는다 — 경계
   provider(Repository/UseCase)는 src/di.dart에 둔다.
   라우터·DI 배선은 각 앱 소유, 공통 부트스트랩 골격은 app_shell (ADR-0007).
   app_shell은 feature를 모른다.
2. **MVI**: 화면 = screen/view_model/state/intent/effect 5파일.
   View는 ViewModel의 `onIntent(...)`만 호출. 1회성 이벤트(스낵바/네비게이션)는 Effect.
3. **Result**: Repository는 throw 하지 않고 `Result<T>` 반환.
   예외 변환은 계층별 책임 (DioException → mapDioException 등).
4. **DI**: provider는 전부 `@riverpod` codegen. 교체 지점은 bootstrap.dart overrides에 집중.
5. **비밀값**: 코드/커밋에 API 키 금지. `env/*.local.json` + `--dart-define-from-file`.
   토큰은 SecureStore에만 저장.
6. **다른 패키지는 barrel만 import** (`package:xxx/xxx.dart`). src/ 직접 접근 금지.
7. ViewModel의 `await` 뒤에는 `if (!ref.mounted) return;`.
8. **사용자 노출 문자열은 app_l10n의 ARB에만** 둔다 (`context.l10n.키`).
   State/Effect에는 문구 대신 AppException을 담고 View가 localizedMessage로 변환.
   AppException.message는 개발자용(영문 로그) 설명.

## 작업 절차

- 새 feature: docs/manual/NEW_FEATURE_GUIDE.md 절차대로 feature_example 복제
- 코드 생성: `./scripts/gen.sh` (또는 해당 패키지에서 `dart run build_runner build --delete-conflicting-outputs`)
- 검증: `./scripts/check.sh` (포맷 + analyze + 전체 테스트) — 작업 완료 전 필수 실행
- 의존성 추가: `dart pub add -C <패키지경로> <패키지>` (루트 workspace가 일괄 해석)
- `*.g.dart`/`*.freezed.dart`는 커밋 대상 (템플릿 복사 직후 실행 가능해야 함)

## 아키텍처 결정 변경 시

docs/adr/에 새 ADR을 추가하고 기존 ADR의 상태를 갱신한다. 결정 이력은 지우지 않는다.
