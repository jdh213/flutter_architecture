/// 로컬 저장소 계층.
///
/// 용도별로 세 가지 저장소를 제공한다:
/// - `KeyValueStore`  : 간단한 설정값 (SharedPreferences 래퍼)
/// - SecureStore      : 토큰 등 민감 정보 (Keychain / EncryptedSharedPreferences)
/// - JsonCacheStore   : API 응답 오프라인 캐시 (drift, TTL 지원)
///
/// feature에 전용 테이블이 필요해지면 src/database/app_database.dart에
/// 테이블을 추가하고 마이그레이션을 작성한다. (docs/manual 참고)
library;

export 'src/database/app_database.dart';
export 'src/database/json_cache_store.dart';
export 'src/key_value_store.dart';
export 'src/secure_store.dart';
