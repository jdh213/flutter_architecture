# ADR-0002: pub workspace 기반 멀티 패키지 구조 채택

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

모듈화 수준을 결정해야 했다. 후보:

1. **폴더 기반 feature-first**: 단일 패키지 안에서 `features/` 폴더로 분리
2. **멀티 패키지**: core, design system, 각 feature를 독립 패키지로 분리

## 결정: 멀티 패키지 (Dart 네이티브 pub workspace)

- **의존 규칙이 컴파일러로 강제된다.** 폴더 구조는 규율에 의존하지만,
  패키지 경계는 pubspec에 없는 의존성을 import 자체가 불가능하게 만든다.
  (예: feature_example이 feature_auth를 import 하면 컴파일 에러)
- **코드 생성 범위가 패키지 단위로 격리**되어 build_runner가 빨라진다.
- 팀이 커지면 feature 단위 오너십 분리가 자연스럽다.

melos 대신 **Dart 3.6+ 네이티브 workspace**를 사용한다:
- 루트 `pubspec.yaml`의 `workspace:` 목록 + 각 패키지 `resolution: workspace`
- 루트에서 `flutter pub get` 한 번으로 전체 해석, lock 파일도 하나
- 외부 도구 의존성 제거 (melos가 하던 스크립트 실행은 `scripts/*.sh`로 충분)

## 패키지 명명

- 공통 인프라: `app_core`, `app_mvi`, `app_network`, `app_storage`, `app_design_system`
- 기능: `feature_auth`, `feature_example`, …
- 실행 앱: `apps/app` (조립 전용)

`core` 같은 무접두사 이름은 pub.dev 패키지와의 이름 충돌 위험이 있어
`app_` 접두사를 사용한다.

## 트레이드오프 (감수한 것)

- 패키지 생성/의존성 추가의 관리 비용이 폴더 방식보다 크다
  → `NEW_FEATURE_GUIDE.md`의 복제 절차로 완화
- 순환 의존이 생기면 pub이 거부한다 → 의존성 역전 패턴으로 해결
  (ARCHITECTURE.md 3절)
