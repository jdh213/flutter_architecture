# 새 기능(feature) 추가 가이드

`feature_example`을 원본으로 삼아 복제하는 것이 기본 절차다.
아래는 "북마크(bookmark)" 기능을 추가한다고 가정한 전체 과정이다.

## 1. 패키지 생성

```bash
cp -R packages/features/feature_example packages/features/feature_bookmark
cd packages/features/feature_bookmark
rm -rf .dart_tool
```

- `pubspec.yaml`의 `name: feature_example` → `feature_bookmark`
- 루트 `pubspec.yaml`의 `workspace:` 목록에 `packages/features/feature_bookmark` 추가
- `apps/app/pubspec.yaml`의 dependencies에 `feature_bookmark:` 추가
- 루트에서 `flutter pub get`

## 2. domain 작성 — 무엇을 다루는 기능인가

```text
src/domain/
├── entities/
│   └── bookmark.dart              # freezed 엔티티. JSON을 모른다.
└── repositories/
    └── bookmarks_repository.dart  # abstract interface. Result<T> 반환.
```

체크리스트:
- [ ] 엔티티는 `@freezed abstract class` + 필수 필드
- [ ] Repository 인터페이스의 모든 메서드가 `Future<Result<...>>`

## 3. data 작성 — 어디서 가져오는가

```text
src/data/
├── datasources/
│   ├── remote/
│   │   └── bookmarks_api.dart          # Dio 주입. 예외를 처리하지 않는다 (그대로 던짐).
│   └── local/                          # 로컬 소스가 있을 때만 (예: feature_auth의 token store)
├── dtos/
│   └── bookmark_dto.dart               # freezed + json_serializable + toDomain()
└── repositories/
    └── bookmarks_repository_impl.dart  # safeApiCall + (필요시) JsonCacheStore 폴백
```

체크리스트:
- [ ] API 클래스는 `ref.watch(dioProvider)` 주입 (`@riverpod` 함수 provider, 구현 파일 옆)
- [ ] Repository 구현은 `safeApiCall(...)`로 감싸 Result 반환
- [ ] 오프라인이 필요하면 `posts_repository_impl.dart`의 캐시 폴백 패턴 복제
- [ ] `xxxRepositoryProvider`는 **`src/di.dart`에** 둔다 (ADR-0005) —
      presentation이 data 파일을 import 하지 않도록. 화면과 함께 dispose 되어도
      무방하면 기본(autoDispose), 앱 전역 공유가 필요하면 `keepAlive: true`
- [ ] 에러 message는 개발자용 영문 설명 — 사용자 문구는 arb 키로 (CONVENTIONS의 l10n 절)

## 4. presentation 작성 — MVI 5파일

```text
src/presentation/bookmark_list/
├── bookmark_list_screen.dart      # View
├── bookmark_list_view_model.dart  # Notifier + MviEffectEmitter
├── bookmark_list_state.dart       # freezed 단일 상태
├── bookmark_list_intent.dart      # sealed
└── bookmark_list_effect.dart      # sealed (없으면 파일 생략)
```

체크리스트:
- [ ] View는 `onIntent(...)` 외 ViewModel 메서드 호출 금지
- [ ] `build()`에서 `ref.onDispose(disposeEffects)` (Effect 사용 시)
- [ ] 초기 로드는 `unawaited(Future.microtask(_load))`
- [ ] 모든 `await` 뒤 `if (!ref.mounted) return;`
- [ ] 화면 이동은 `NavigateToXxx` Effect → View의 onEffect에서 `context.push`
- [ ] `static const routePath` 정의

## 5. 공개 API 결정 (barrel)

`lib/feature_bookmark.dart`에서 **앱이 필요로 하는 것만** export 한다.
보통 Screen과 (다른 배선에 필요한) provider 정도면 충분하다.

## 6. 라우트 등록

`apps/app/lib/src/router/app_router.dart`의 `routes:`에 GoRoute 추가:

```dart
GoRoute(
  path: BookmarkListScreen.routePath,
  builder: (context, state) => const BookmarkListScreen(),
),
```

## 7. 코드 생성 + 테스트

```bash
cd packages/features/feature_bookmark
dart run build_runner build --delete-conflicting-outputs
```

- ViewModel 테스트: `post_list_view_model_test.dart` 복제 (Repository mock)
- Repository 테스트: `posts_repository_impl_test.dart` 복제 (API mock + in-memory drift)
- `scripts/gen.sh`, `scripts/test.sh`의 PACKAGES 목록에 새 패키지 추가

## 8. 마지막 확인

```bash
./scripts/check.sh   # 포맷 + 분석 + 전체 테스트
```

---

## 부록 A — 인증 확장 (실서버 연동 시)

1. `feature_auth/src/data/auth_api.dart`: `authApiProvider`에서
   `FakeAuthApi()` → `RemoteAuthApi(ref.watch(dioProvider))` 교체, 엔드포인트 수정
2. 리프레시 토큰이 있다면:
   - `AuthTokenStore`에 refresh 토큰 read/write 추가
   - `app_network`의 `AuthTokenInterceptor.onError`에서
     401 → refresh 시도 → 성공 시 원 요청 재시도 로직 구현
3. 소셜 로그인: `AuthApi`에 `loginWithKakao()` 등 추가 — Repository/화면 구조는 유지

## 부록 B — UseCase는 언제 추가하나

기본은 ViewModel → Repository 직행이다. 다음 중 하나가 생기면
`src/domain/usecases/`에 UseCase를 추가한다 (판단 기준: ADR-0005):

1. 같은 비즈니스 로직을 여러 ViewModel이 공유할 때
2. 하나의 작업이 여러 Repository/호출을 조합할 때
3. 표현도 데이터 접근도 아닌 도메인 규칙이 있을 때

절차:
- [ ] `domain/usecases/xxx_use_case.dart` — 순수 Dart, Repository 인터페이스만 의존, `call()` 반환형은 `Future<Result<T>>`
- [ ] `src/di.dart`에 provider 배선 (domain은 data의 provider를 import 할 수 없으므로)
- [ ] ViewModel의 호출 대상을 Repository → UseCase로 교체
- [ ] UseCase 단독 테스트 작성 (Repository mock)
- [ ] 위임만 하는 pass-through UseCase는 만들지 않는다

살아있는 예제: `feature_example`의 `GetPostDetailUseCase`
(병렬 조합 + 도메인 규칙 + 부분 실패 정책 + 테스트).

## 부록 C — feature에 전용 DB 테이블이 필요할 때

`JsonCacheStore`(key-JSON)로 부족하고 쿼리가 필요한 경우:

1. `app_storage/src/database/app_database.dart`에 Table 클래스 추가
2. `schemaVersion` +1, `MigrationStrategy`의 `onUpgrade`에 마이그레이션 작성
3. `app_storage`에서 `dart run build_runner build`
4. DAO 또는 쿼리 메서드를 app_storage에 추가하고 barrel로 export
