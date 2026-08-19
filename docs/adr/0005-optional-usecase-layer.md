# ADR-0005: UseCase는 선택적 계층 — 조건 충족 시에만 도입

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

이 템플릿은 클린 아키텍처의 핵심 원칙(의존성 규칙, DIP, 계층 분리,
DTO/엔티티 분리)을 따르지만, 교과서식 구성 요소인 UseCase(Interactor)
계층의 상시 존재 여부를 명확히 해야 했다.

- 교과서식: `View → ViewModel → UseCase → Repository`
- 이 템플릿의 기본: `View → ViewModel → Repository` (직행)

## 결정

**UseCase는 상시 계층이 아니라, 아래 조건 중 하나가 생길 때만 도입한다.**
(Flutter 공식 아키텍처 가이드의 "선택적 계층" 권고와 동일한 입장)

1. **공유**: 같은 비즈니스 로직을 두 개 이상의 ViewModel이 사용할 때
2. **조합**: 하나의 작업이 여러 Repository(또는 여러 호출)를 엮을 때
3. **복잡한 도메인 규칙**: ViewModel(표현)에도 Repository(데이터 접근)에도
   속하지 않는 규칙이 있을 때

조건 없이 Repository 호출을 그대로 위임만 하는 **pass-through UseCase는
금지**한다. 계층을 형식적으로 채우는 것은 클린 아키텍처가 아니라 그 변질이다.

## 구현 규약

- **위치**: `feature_x/lib/src/domain/usecases/` — 순수 Dart,
  Repository 인터페이스에만 의존한다.
- **형태**: `call()` 메서드를 가진 클래스. `Future<Result<T>>`를 반환한다.
- **배선**: UseCase provider는 `feature_x/lib/src/di.dart`에 둔다.
  provider 위치의 일반 규칙은 "그 타입을 만들 줄 아는 가장 안쪽 파일"이다 —
  Repository provider는 구현 옆(data)이 그 위치지만, UseCase의 배선에는
  data의 provider가 필요하므로 domain에 둘 수 없다(의존성 규칙 위반).
  그래서 조립 전용 파일(di.dart)이 담당한다.

## 예제

`feature_example`의 `GetPostDetailUseCase`가 세 조건을 실제로 시연한다:

- 조합: 상세 조회 + 목록 조회를 record `.wait`로 병렬 실행해 하나로 합침
- 도메인 규칙: "같은 작성자 / 자기 자신 제외 / 최대 3개"
- 부분 실패 정책: 상세 실패 = 전체 실패, 관련 글 실패 = 빈 목록으로 무시

ViewModel(`PostDetailViewModel`)은 UseCase만 호출하며, 규칙이 도메인으로
이동한 만큼 표현 로직만 남는다. 테스트는 UseCase 단독으로 작성한다
(`get_post_detail_use_case_test.dart`).

## 결과

- 새 feature는 기본적으로 ViewModel → Repository 직행으로 시작한다.
- 위 조건이 생기면 domain/usecases/에 추가하고 di.dart에 배선한다 —
  구조 변경 없이 계층이 확장된다.
- 관련: [ADR-0003 (MVI)](0003-mvi-presentation-pattern.md)
