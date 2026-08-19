# 새 앱 추가 가이드 (멀티 앱)

같은 feature들을 조합해 두 번째 앱(예: 관리자 앱)을 만드는 절차.
공통 골격은 app_shell이 제공하므로(ADR-0007), 새 앱에는 **그 앱 고유의
조립**만 작성한다.

## 1. 앱 생성 + workspace 등록

```bash
flutter create --org com.template --project-name admin_app \
  --platforms android,ios --empty apps/admin_app
```

- `apps/admin_app/pubspec.yaml`에 `resolution: workspace` 추가
- 루트 `pubspec.yaml`의 `workspace:` 목록에 `apps/admin_app` 추가
- 의존성 추가: `app_core`, `app_shell`, `app_design_system`, `app_l10n`,
  `flutter_riverpod`, `go_router` + **이 앱이 포함할 feature들만**
- 기본 생성된 `analysis_options.yaml`은 삭제 (루트 설정 상속)

## 2. 조립 작성 (apps/app을 본보기로)

```text
apps/admin_app/lib/
├── main_{dev,stg,prod}.dart   # EnvConfig 상수 + bootstrap 호출
└── src/
    ├── bootstrap.dart          # bootstrapApp(overrides: ..., afterInit: ..., app: ...)
    ├── app.dart                # MaterialApp.router + 테마 + l10n delegates
    └── router/app_router.dart  # 이 앱의 화면 지도 (라우터는 앱마다 소유)
```

- bootstrap: `apps/app/lib/src/bootstrap.dart`를 복사해 이 앱에 필요한
  overrides만 남긴다 (인증이 없는 앱이면 token 배선 제거)
- 라우터: 이 앱이 포함하는 feature의 화면들로 GoRoute 구성

## 3. flavor / 실행 구성

- Android: `apps/app/android/app/build.gradle.kts`의 flavor 블록과
  `buildFeatures.resValues`, `compileSdk` 설정을 복사
- `.run/`에 실행 구성 추가 (`admin-dev.run.xml` 등 — 기존 파일 복제 후
  filePath만 교체)

## 4. 스크립트/CI 등록

- `scripts/gen.sh`, `scripts/test.sh`의 PACKAGES 목록에 `apps/admin_app` 추가
  (codegen/테스트가 있는 경우)
- CI는 루트 `flutter pub get` + 스크립트 기반이라 자동으로 포함된다

## 체크리스트

- [ ] 새 앱은 조립만 한다 — 비즈니스 로직/화면은 feature 패키지로
- [ ] 라우터·overrides는 이 앱 소유, 공통 골격은 app_shell 사용
- [ ] 포함하지 않는 feature는 pubspec에서도 의존하지 않는다
