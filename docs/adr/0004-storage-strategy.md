# ADR-0004: 로컬 저장소 3분할 전략

- 상태: 채택 (2026-08-19)
- 결정자: Zohnny

## 맥락

로컬 저장소 요구는 성격이 다른 세 종류로 나뉜다:
설정값, 민감 정보(토큰), API 응답 캐시.
하나의 저장소로 뭉치면 보안 요구와 스키마 요구가 충돌한다.

## 결정

용도별로 저장소를 분리하고 각각 인터페이스로 추상화한다 (`app_storage`):

| 저장소 | 백엔드 | 용도 | 금지 |
|---|---|---|---|
| `KeyValueStore` | SharedPreferences | 간단한 설정값 | 민감 정보 |
| `SecureStore` | Keychain / EncryptedSharedPreferences | 토큰 등 민감 정보 | 대용량 데이터 |
| `JsonCacheStore` | drift (SQLite) | API 응답 오프라인 캐시 (TTL) | — |

### JsonCacheStore를 범용 key-JSON 테이블로 만든 이유

feature마다 전용 drift 테이블을 요구하면, 캐시가 필요한 모든 feature가
app_storage에 테이블을 추가해야 해서 (1) app_storage가 feature 지식으로 오염되고
(2) 스키마 마이그레이션 부담이 캐시 용도에 비해 과하다.

key-JSON(payload) + updatedAt 구조면:
- feature는 스키마 없이 `put/get(decode:)`만으로 오프라인 캐시를 얻는다
- TTL은 updatedAt으로 일괄 처리
- 정교한 쿼리가 정말 필요해지면 그때 전용 테이블을 추가한다
  (NEW_FEATURE_GUIDE.md 부록 B)

### drift를 선택한 이유 (vs hive/isar/sqflite)

- SQL + 타입 세이프 쿼리 + 마이그레이션 체계가 검증되어 있고 유지보수가 활발
- 전용 테이블로 확장할 때 갈아탈 필요가 없다
- 테스트에서 `NativeDatabase.memory()`로 실물 DB를 그대로 사용 가능

## 결과

- 인터페이스(`KeyValueStore`, `SecureStore`)에는 테스트용 인메모리 구현을 함께 제공한다.
- Repository 캐시 폴백 패턴은 `feature_example`의 `PostsRepositoryImpl` 참고.
