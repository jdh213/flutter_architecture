# Flavor & 환경/비밀값 관리

## 구조

flavor는 세 겹으로 구성된다:

| 겹 | 담당 | 정의 위치 |
|---|---|---|
| Dart 진입점 | `EnvConfig` (API 주소, 로그 여부) | `apps/app/lib/main_{dev,stg,prod}.dart` |
| Android productFlavor | applicationId suffix, 앱 이름 | `apps/app/android/app/build.gradle.kts` |
| iOS scheme/xcconfig | Bundle ID suffix, 앱 이름 | Xcode (아래 수동 설정 필요) |

실행:

```bash
cd apps/app
flutter run --flavor dev  -t lib/main_dev.dart
flutter run --flavor stg  -t lib/main_stg.dart
flutter run --flavor prod -t lib/main_prod.dart

# 빌드
flutter build apk --flavor prod -t lib/main_prod.dart
flutter build ipa --flavor prod -t lib/main_prod.dart   # iOS 스킴 설정 후
```

## Android Studio / IntelliJ에서 실행

**워크스페이스 루트 폴더를 그대로 연다** (apps/app이 아니라).
루트는 Flutter 앱이 아니므로 IDE가 자동으로 실행 버튼을 만들지 않지만,
`.run/` 폴더에 공유 Run Configuration(dev/stg/prod)이 포함되어 있어
프로젝트를 열면 상단 실행 구성 드롭다운에 바로 나타난다.

- 각 구성은 `apps/app/lib/main_<flavor>.dart` + `--flavor <flavor>`로 연결되어 있다.
- 새 flavor를 추가하면 `.run/<flavor>.run.xml`도 복제해서 만들어준다.
- Gradle "Build Variants" 패널 등 Android 네이티브 빌드 UI가 필요하면
  (네이티브 코드 수정 시에만) `apps/app/android`를 별도 창으로 연다.
- VS Code 사용자는 `.vscode/launch.json`에 같은 구성을 만들면 된다
  (`program: apps/app/lib/main_dev.dart`, `args: ["--flavor", "dev"]`).

## iOS flavor 설정 (수동, 최초 1회)

Android와 달리 iOS는 Xcode에서 스킴을 만들어야 한다:

1. `open apps/app/ios/Runner.xcworkspace`
2. **Scheme 복제**: Product > Scheme > Manage Schemes에서 Runner를 3번 Duplicate →
   이름을 `dev`, `stg`, `prod`로 지정 (Shared 체크)
3. **Configuration 복제**: 프로젝트 설정 > Info > Configurations에서
   Debug/Release/Profile을 flavor별로 복제 (`Debug-dev`, `Release-dev`, …)
4. 각 스킴이 해당 Configuration을 사용하도록 연결
5. Build Settings에서 Configuration별로
   `PRODUCT_BUNDLE_IDENTIFIER`(`com.template.app.dev` 등)와 Display Name 지정

> 참고: flavor가 필수가 아닌 프로젝트 초기에는 iOS 스킴 없이
> `flutter run -t lib/main_dev.dart`(--flavor 생략)로 개발해도 된다.
> Android도 --flavor 없이 실행하려면 build.gradle.kts의 flavor 블록을 제거한다.

## 비밀값 주입 (API 키 등)

**규칙: 비밀값은 절대 코드/커밋에 넣지 않는다.**

1. `apps/app/env/dev.local.json.example`을 복사:

   ```bash
   cp apps/app/env/dev.local.json.example apps/app/env/dev.local.json
   ```

2. 실제 값 입력 (`*.local.json`은 .gitignore에 포함되어 커밋되지 않는다)

3. 실행 시 주입:

   ```bash
   flutter run --flavor dev -t lib/main_dev.dart \
     --dart-define-from-file=env/dev.local.json
   ```

4. 코드에서 읽기 (컴파일 타임 상수):

   ```dart
   const exampleApiKey = String.fromEnvironment('EXAMPLE_API_KEY');
   ```

CI에서는 GitHub Actions secrets → 빌드 스텝에서 `--dart-define`으로 전달한다.

## 환경 추가/변경

- 서버 주소 등 비밀이 아닌 환경값: `main_*.dart`의 `EnvConfig`에 필드 추가
  (`app_core/src/env/env_config.dart`)
- 새 flavor(예: qa): main_qa.dart 추가 + build.gradle.kts flavor 추가 + iOS 스킴 추가
