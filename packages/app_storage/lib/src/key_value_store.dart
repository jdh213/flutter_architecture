import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'key_value_store.g.dart';

/// 간단한 설정값 저장소.
///
/// 인터페이스로 추상화되어 있어 테스트에서 [InMemoryKeyValueStore]로
/// 교체할 수 있다. 민감 정보는 절대 여기에 저장하지 않는다 → SecureStore 사용.
abstract interface class KeyValueStore {
  Future<String?> getString(String key);

  Future<void> setString(String key, String value);

  Future<bool?> getBool(String key);

  Future<void> setBool(String key, {required bool value});

  Future<int?> getInt(String key);

  Future<void> setInt(String key, int value);

  Future<void> remove(String key);
}

class SharedPrefsKeyValueStore implements KeyValueStore {
  SharedPrefsKeyValueStore(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<String?> getString(String key) => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<bool?> getBool(String key) => _prefs.getBool(key);

  @override
  Future<void> setBool(String key, {required bool value}) =>
      _prefs.setBool(key, value);

  @override
  Future<int?> getInt(String key) => _prefs.getInt(key);

  @override
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);
}

/// 테스트용 인메모리 구현.
class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, Object> _map = {};

  @override
  Future<String?> getString(String key) async => _map[key] as String?;

  @override
  Future<void> setString(String key, String value) async => _map[key] = value;

  @override
  Future<bool?> getBool(String key) async => _map[key] as bool?;

  @override
  Future<void> setBool(String key, {required bool value}) async =>
      _map[key] = value;

  @override
  Future<int?> getInt(String key) async => _map[key] as int?;

  @override
  Future<void> setInt(String key, int value) async => _map[key] = value;

  @override
  Future<void> remove(String key) async => _map.remove(key);
}

@Riverpod(keepAlive: true)
KeyValueStore keyValueStore(Ref ref) =>
    SharedPrefsKeyValueStore(SharedPreferencesAsync());
