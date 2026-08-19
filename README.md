# Flutter Architecture Template

새 Flutter 프로젝트를 시작할 때 **복사해서 바로 개발에 들어가기 위한** 모듈러 템플릿.
멀티 패키지(pub workspace) + Riverpod 3(상태관리 & DI) + MVI 프레젠테이션 패턴을 기본으로 한다.

프로젝트 자체가 살아있는 매뉴얼이다 — `feature_example` 패키지가
API 호출 → 오프라인 캐시 → Repository → ViewModel → UI까지 전 계층을 관통하는
예제이며, 새 기능은 이 패키지를 복제하는 것으로 시작한다.

## 빠른 시작

```bash
flutter pub get          # 워크스페이스 전체 의존성 해석 (루트에서 1회)
./scripts/gen.sh         # 코드 생성 (riverpod / freezed / drift / json)
./scripts/check.sh       # 포맷 + 분석 + 전체 테스트 (CI와 동일)

# 실행 (dev flavor)
cd apps/app
flutter run --flavor dev -t lib/main_dev.dart
```

로그인 화면에서 아무 이메일/비밀번호나 입력하면 된다 (FakeAuthApi).
로그인 후 jsonplaceholder API의 게시글 목록이 표시된다.

> **Android Studio**: 워크스페이스 **루트 폴더를 연다**. 루트는 Flutter 앱이 아니라서
> 실행 버튼이 자동 생성되지 않지만, `.run/`의 공유 실행 구성(dev/stg/prod)이
> 드롭다운에 바로 나타난다. (자세히: docs/manual/FLAVORS_AND_ENV.md)

## 구조

```text
flutter_architecture/
├── apps/
│   └── app/                    # composition root — 조립만 한다
│       ├── lib/main_{dev,stg,prod}.dart   # flavor 진입점
│       └── lib/src/{bootstrap,app,router/…}
├── packages/
│   ├── app_core/               # 순수 Dart: Result, AppException, Logger, EnvConfig
│   ├── app_mvi/                # MVI 계약: Intent/State/Effect, EffectEmitter/Listener
│   ├── app_network/            # dio + 인터셉터 + 예외 매핑 + safeApiCall
│   ├── app_storage/            # KeyValueStore / SecureStore / JsonCacheStore(drift)
│   ├── app_design_system/      # 토큰, 테마, 공용 위젯
│   └── features/
│       ├── feature_auth/       # 인증 (세션 컨트롤러, 로그인 MVI 화면)
│       └── feature_example/    # ★ 예제 수직 슬라이스 — 새 feature의 원본
├── docs/                       # 설계 문서 & ADR & 가이드
├── scripts/                    # gen / test / check
└── pubspec.yaml                # pub workspace 루트
```

계층 의존 방향 (역방향 import 금지):

```text
app  →  feature_*  →  app_network / app_storage / app_mvi / app_design_system  →  app_core
```

## 새 프로젝트 시작하기 (템플릿 복사 절차)

1. 폴더 복사 후 `.git` 삭제, `git init`
2. 식별자 변경
   - Android: `apps/app/android/app/build.gradle.kts`의 `applicationId`, `namespace`
   - iOS: Xcode에서 Bundle Identifier
   - 앱 이름: `build.gradle.kts`의 `resValue("string", "app_name", …)` 3곳
3. `apps/app/lib/main_*.dart`의 `apiBaseUrl`을 실제 서버 주소로 교체
4. `packages/app_design_system/.../app_theme.dart`의 `_seedColor`를 브랜드 색으로 교체
5. `feature_auth`의 `authApiProvider`에서 `FakeAuthApi` → `RemoteAuthApi` 교체
6. 첫 기능 개발: [docs/manual/NEW_FEATURE_GUIDE.md](docs/manual/NEW_FEATURE_GUIDE.md) 따라 `feature_example` 복제
7. 예제가 더 이상 필요 없으면 `feature_example` 패키지와 라우트를 삭제

## 자주 쓰는 명령

| 명령 | 설명 |
|---|---|
| `flutter pub get` (루트) | 워크스페이스 전체 의존성 해석 |
| `./scripts/gen.sh` | 전체 패키지 코드 생성 |
| `./scripts/test.sh` | 전체 패키지 테스트 |
| `./scripts/check.sh` | CI와 동일한 로컬 검증 |
| `./scripts/reset.sh` | 빌드 꼬임 리셋: clean → pub get → codegen (Android의 clean+sync+rebuild) |
| `cd <패키지> && dart run build_runner watch` | 개발 중 해당 패키지 코드 생성 감시 |
| `flutter run --flavor dev -t lib/main_dev.dart` | dev 실행 (apps/app에서) |

## 문서

- [아키텍처](docs/ARCHITECTURE.md) — 계층, 의존 규칙, MVI 데이터 흐름, DI 배선
- [컨벤션](docs/CONVENTIONS.md) — 네이밍, 폴더, import, lint, 생성 파일 정책
- [새 기능 추가 가이드](docs/manual/NEW_FEATURE_GUIDE.md) — feature 추가 절차 (step-by-step)
- [Flavor & 환경/비밀값](docs/manual/FLAVORS_AND_ENV.md) — flavor, iOS 스킴, dart-define 비밀값 주입
- [의존성 업그레이드](docs/manual/UPGRADING.md) — 버전이 analyzer 축으로 묶이는 원리와 업그레이드 절차
- ADR (아키텍처 결정 기록)
  - [0001 — Bloc 대신 Riverpod 3](docs/adr/0001-riverpod-over-bloc.md)
  - [0002 — pub workspace 멀티 패키지](docs/adr/0002-pub-workspace-multi-package.md)
  - [0003 — MVI 프레젠테이션 패턴](docs/adr/0003-mvi-presentation-pattern.md)
  - [0004 — 저장소 전략](docs/adr/0004-storage-strategy.md)
