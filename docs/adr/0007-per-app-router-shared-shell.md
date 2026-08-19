# ADR-0007: 라우터는 앱별 소유, 공통 골격은 app_shell

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

"라우터가 apps/app에 있는 것이 맞는가, app에는 진입점만 두는 게 낫지
않은가"라는 질문에서 출발했다. 이 템플릿은 보일러플레이트이므로
멀티 앱(apps/app 외 추가 앱) 시나리오까지 지금 준비해 둔다.

## 결정 1: 라우터·DI 배선은 각 앱이 소유한다

라우팅 그래프는 "어떤 화면들이 존재하고 어떻게 연결되는가"라는
**조립 정보**다. 이를 알려면 모든 feature를 알아야 하는데, feature끼리는
서로를 모르는 것이 1번 절대 규칙이므로 전체 지도를 그릴 수 있는 곳은
의존성 그래프 꼭대기(composition root)뿐이다.

또한 멀티 앱에서 **라우터는 공유 대상이 아니다** — 앱마다 포함하는
feature와 화면 지도가 다르다. 별도 `app_router` 패키지로 빼면 모든
feature에 의존하는 패키지가 하나 더 생길 뿐이며(제2의 composition root),
그 패키지를 공유하는 순간 모든 앱이 모든 feature를 끌고 가게 된다.

같은 이유로 bootstrap의 overrides(앱별 DI 배선)와 라우터 전용 대기
경로(스플래시 — 라우터 파일 안에 인라인)도 각 앱이 소유한다.

한편 위젯의 소속은 의존성으로 판정한다: LogoutButton은 feature_auth에만
의존하므로 **feature_auth가 소유·export** 하고, 그것을 다른 feature의
화면(appBarActions)에 **주입하는 행위**만 앱(라우터)이 담당한다.
앱에는 자체 UI 파일이 남지 않는다 — 최종 구성:
`main_*.dart + src/{app,bootstrap,router/app_router}.dart`.

## 결정 2: 앱과 무관한 골격은 app_shell로 공유한다

모든 앱에서 완전히 동일한 부분만 `packages/app_shell`의 [bootstrapApp]으로
추출했다:

1. 바인딩 초기화
2. EnvConfig 주입 + 앱별 overrides로 ProviderContainer 구성
3. 전역 에러 훅 배선 (FlutterError / PlatformDispatcher → ErrorReporter)
4. afterInit 실행 후 runApp

app_shell은 **feature를 일절 모른다** (app_core만 의존). 그래서 어떤 앱
조합에서도 재사용되며, 앱별로 다른 것은 전부 파라미터다.

## 결과

- 각 앱의 bootstrap은 "이 앱 고유의 조립"만 선언하는 파일이 된다
  (apps/app/lib/src/bootstrap.dart 참고 — overrides + afterInit + 루트 위젯).
- 새 앱 추가 절차는 docs/manual/NEW_APP_GUIDE.md.
- 관련: [ADR-0006 (typed routes 기각)](0006-string-routes-over-typed-routes.md) —
  "라우트를 아는 자 = composition root"라는 동일한 제약에서 나온 결정.
