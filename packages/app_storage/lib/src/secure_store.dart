import 'package:app_core/app_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_store.g.dart';

/// 민감 정보(액세스 토큰, 리프레시 토큰 등) 전용 저장소.
///
/// iOS Keychain / Android EncryptedSharedPreferences를 사용한다.
/// 인터페이스로 추상화되어 있어 테스트에서 [InMemorySecureStore]로 교체한다.
abstract interface class SecureStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

class FlutterSecureStore implements SecureStore {
  const FlutterSecureStore(this._storage);

  final FlutterSecureStorage _storage;

  // 플랫폼 예외(PlatformException 등)를 앱 예외 체계로 변환한다 —
  // "저장소 오류 → CacheException" 계약 (app_exception.dart 참고).
  Future<T> _guard<T>(Future<T> Function() body, String operation) async {
    try {
      return await body();
    } on Exception catch (e, st) {
      throw CacheException(
        message: 'SecureStore $operation failed',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<String?> read(String key) =>
      _guard(() => _storage.read(key: key), 'read');

  @override
  Future<void> write(String key, String value) =>
      _guard(() => _storage.write(key: key, value: value), 'write');

  @override
  Future<void> delete(String key) =>
      _guard(() => _storage.delete(key: key), 'delete');
}

/// 테스트용 인메모리 구현.
class InMemorySecureStore implements SecureStore {
  final Map<String, String> _map = {};

  @override
  Future<String?> read(String key) async => _map[key];

  @override
  Future<void> write(String key, String value) async => _map[key] = value;

  @override
  Future<void> delete(String key) async => _map.remove(key);
}

@Riverpod(keepAlive: true)
SecureStore secureStore(Ref ref) =>
    const FlutterSecureStore(FlutterSecureStorage());
