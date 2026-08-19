# ADR-0001: 상태관리 + DI로 Bloc 대신 Riverpod 3 채택

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

새 Flutter 프로젝트의 표준 템플릿에 상태관리 스택을 확정해야 했다.
요구사항: **Android Hilt처럼 의존성 주입(DI)까지 겸해야 한다.**
후보는 Riverpod 3과 Bloc.

## 비교

### Bloc 노선

Bloc 자체는 DI 기능이 없어 `get_it` + `injectable` 조합을 붙여야 한다.
이 조합은 Hilt와 가장 닮았다 — `@injectable`, `@module`, `@lazySingleton`
어노테이션 + 코드 생성으로 의존성 그래프를 만든다.
Android 출신에게는 Cubit ≈ ViewModel + StateFlow, injectable ≈ Hilt로
멘탈 모델이 거의 1:1 매핑되는 것이 장점.

단점:
- **세 가지 시스템 동시 운영**: 상태관리(bloc) + 서비스 로케이터(get_it) + 코드젠(injectable)
- get_it은 **런타임 등록** 방식 — 등록을 빼먹으면 컴파일이 아니라 런타임에 터진다.
  (Hilt가 컴파일 타임에 잡아주는 것과 결정적으로 다른 부분)

### Riverpod 3 노선

상태관리와 DI가 하나의 시스템이다. Provider가 ViewModel 역할과
Hilt 모듈 역할을 동시에 한다.

- 의존성 그래프가 **컴파일 타임에 검증**된다 (빼먹으면 컴파일 에러)
- 테스트에서 `ProviderContainer(overrides: [...])`로 갈아끼우는 것이
  Hilt의 `@TestInstallIn`과 같은 개념
- `@riverpod` 어노테이션 + 코드젠이라 작성 경험도 Hilt와 유사
- 멀티 패키지 구성에서 domain/data 레이어는 Flutter 의존성 없는
  순수 Dart용 `riverpod` 패키지만 쓰면 되어 레이어 순수성 유지

## 결정: Riverpod 3

1. **"Hilt처럼 DI까지"라는 요구를 시스템 하나로 해결** — Bloc 노선은 세 패키지를
   조합해야 같은 것을 얻는다. 템플릿의 부품 수가 적을수록 복사해서 쓸 때
   이해 비용이 낮다.
2. **컴파일 타임 안전성** — get_it의 런타임 미등록 크래시가 원천적으로 없다.
   Hilt에서 넘어온 개발자가 get_it에서 가장 당황하는 지점이 바로 이것이다.
3. **생태계 방향** — 2026년 현재 신규 Flutter 프로젝트의 사실상 표준이며
   커뮤니티 예제·문서·채용 시장 모두 Riverpod 쪽이 우세하다.

## 기각된 대안

- **Bloc + get_it + injectable**: 팀 전체가 Android 출신이라 Hilt/MVVM 멘탈 모델
  그대로 가는 것이 온보딩에 유리한 경우에만 고려할 가치가 있다.
  개인/소규모 표준 템플릿 용도로는 Riverpod로 새 표준을 익히는 편이 장기적 이득.
- **Provider + ChangeNotifier**: 단순하지만 대규모에서 한계. DI 요구 미충족.

## 결과

- 모든 provider는 `@riverpod` codegen으로 작성한다.
- DI 배선(교체 지점)은 `apps/app/lib/src/bootstrap.dart`의 overrides에 모은다.
- MVI ViewModel도 Riverpod Notifier로 구현한다 → [ADR-0003](0003-mvi-presentation-pattern.md)
