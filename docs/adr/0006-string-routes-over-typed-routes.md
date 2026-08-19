# ADR-0006: 문자열 경로 라우팅 유지 (go_router_builder 기각)

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

아키텍처 리뷰에서 "프로젝트 전체가 codegen 노선인데 라우트만 문자열
(`'/posts/:postId'`)로 관리한다"는 비일관성이 지적됐다.
go_router_builder(typed routes)를 도입하면 라우트도 컴파일 타임 안전해진다.

## 검토 결과: 기각

typed routes의 라우트 클래스는 **라우팅 그래프를 소유한 곳(apps/app)에
생성**된다. 그런데 화면 이동을 요청하는 쪽은 feature 패키지다
(예: feature_example의 목록 → 상세 Effect). feature가 app의 라우트
클래스를 참조하려면 **feature → app 역방향 의존**이 생겨 이 템플릿의
1번 절대 규칙(의존 방향)을 깬다.

우회책들도 검토했으나 기각했다:
- 라우트 전용 공유 패키지 분리 → 화면(feature)과 라우트 정의(공유 패키지)가
  분리되어 오히려 응집도가 떨어지고 패키지가 하나 늘어난다
- 라우트 클래스를 feature마다 생성 → go_router_builder는 단일 라우팅
  트리를 전제로 하므로 부자연스럽다

## 대신 채택한 완화책

- 경로 문자열은 각 화면의 `static const routePath` / `static String pathFor(...)`
  한 곳에만 존재한다. 문자열이 코드베이스에 흩어지지 않으므로
  오타 위험은 화면당 1개 지점으로 수렴한다.
- 라우터(apps/app)는 이 상수만 참조해 GoRoute를 구성한다.

## 재검토 조건

단일 패키지 구조로 전환하거나, go_router_builder가 멀티 패키지 분산
정의를 지원하게 되면 재검토한다.
