import 'package:app_storage/app_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_token_store.g.dart';

/// 액세스 토큰 저장소. 토큰은 반드시 SecureStore에만 저장한다.
class AuthTokenStore {
  const AuthTokenStore(this._secureStore);

  static const String _accessTokenKey = 'auth.access_token';

  final SecureStore _secureStore;

  Future<String?> readAccessToken() => _secureStore.read(_accessTokenKey);

  Future<void> saveAccessToken(String token) =>
      _secureStore.write(_accessTokenKey, token);

  Future<void> clear() => _secureStore.delete(_accessTokenKey);
}

@Riverpod(keepAlive: true)
AuthTokenStore authTokenStore(Ref ref) =>
    AuthTokenStore(ref.watch(secureStoreProvider));
