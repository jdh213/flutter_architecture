# 의존성 업그레이드 가이드

> 자동 점검: `.github/workflows/dependency-check.yaml`이 매주 월요일 09:00(KST)에
> `pub outdated`를 실행해 Summary에 리포트를 남기고, 업그레이드 가능한 직접
> 의존성이 있으면 이슈를 만든다. (GitHub에 push 되어 있어야 동작하며,
> Actions 탭에서 수동 실행도 가능)

## 핵심 이해: 버전은 analyzer를 축으로 묶여 있다

Flutter 코드젠 생태계(riverpod_generator, freezed, drift_dev, json_serializable,
custom_lint/riverpod_lint)는 모두 `analyzer` 패키지에 의존하며, analyzer의
메이저 업데이트가 잦아 **서로 호환되는 버전 조합이 함께 움직인다**.
또한 riverpod_lint는 riverpod 버전을 정확히 pin 한다.

따라서 개별 패키지를 "최신"으로 올리는 것이 아니라,
**pub solver가 골라주는 "최신 호환 세트"를 쓰는 것이 정답**이다.
`flutter pub outdated`에서 Current = Resolvable이면 이미 최적 상태다.

## 정기 업그레이드 절차 (권장: 월 1회 또는 프로젝트 시작 시)

```bash
# 1. 현황 확인 — Resolvable 열이 Current보다 높은 것이 있는지 본다
flutter pub outdated

# 2. 제약 범위 내 업그레이드 (caret 범위 안에서 최신으로)
flutter pub upgrade

# 3. 메이저 버전 점프까지 반영하려면 (pubspec 제약도 함께 수정됨)
flutter pub upgrade --major-versions

# 4. 반드시 재생성 + 전체 검증
./scripts/gen.sh
./scripts/check.sh
```

업그레이드 후 breaking change는 주로 다음에서 발생한다:
- riverpod codegen API (provider 문법) → riverpod 마이그레이션 가이드 확인
- freezed 클래스 선언 규칙 (abstract/sealed 요구사항)
- drift 스키마/쿼리 API

## "Latest에 있는데 왜 안 올라가?" 진단법

```bash
# 특정 패키지를 강제로 올려보면 solver가 충돌 사슬을 설명해준다
dart pub add -C packages/app_core 'riverpod:^X.Y.Z'
# 확인 후 원복: git checkout packages/app_core/pubspec.yaml pubspec.lock
```

전형적인 병목 (2026-08 기준 실측):
- **custom_lint가 analyzer 구버전에 고정** → riverpod_lint → riverpod 전체가 대기
- **freezed stable vs riverpod_generator의 analyzer 요구 범위 불일치**
- 이런 경우 기다리는 것이 맞다. lint를 제거하면 일부 올라가지만
  컴파일 타임 안전장치(이 스택을 선택한 이유)를 잃고, freezed가 dev 버전으로
  끌려가는 등 얻는 것보다 잃는 것이 크다.

## Flutter SDK 업그레이드

```bash
flutter upgrade        # stable 채널 최신으로
flutter --version
./scripts/reset.sh     # SDK 올린 후에는 전체 리셋 권장
./scripts/check.sh
```

SDK를 올리면 더 새로운 analyzer가 해석 가능해져 위 병목이 풀리는 경우가 있다.
단, SDK는 머신 전역 설정이므로 다른 Flutter 프로젝트에도 영향을 준다.
