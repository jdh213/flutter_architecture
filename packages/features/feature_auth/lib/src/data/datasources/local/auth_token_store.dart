import 'dart:convert';

import 'package:app_storage/app_storage.dart';
import 'package:feature_auth/src/domain/entities/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_token_store.g.dart';

/// 인증 세션 로컬 저장소. 토큰과 사용자 프로필 스냅샷을 SecureStore에만 저장한다.
///
/// 프로필 스냅샷은 오프라인 콜드 스타트 시 세션을 유지하기 위한 것이다 —
/// restoreSession()이 서버 검증(me)에 실패해도(일시 장애) 저장된 프로필로
/// Authenticated 진입이 가능하다.
class AuthTokenStore {
  const AuthTokenStore(this._secureStore);

  static const String _accessTokenKey = 'auth.access_token';
  static const String _userKey = 'auth.user';

  final SecureStore _secureStore;

  Future<String?> readAccessToken() => _secureStore.read(_accessTokenKey);

  Future<void> saveAccessToken(String token) =>
      _secureStore.write(_accessTokenKey, token);

  Future<void> saveUser(AuthUser user) => _secureStore.write(
    _userKey,
    jsonEncode({'id': user.id, 'name': user.name, 'email': user.email}),
  );

  Future<AuthUser?> readUser() async {
    final raw = await _secureStore.read(_userKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return AuthUser(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
      );
    } on Exception {
      // 손상된 스냅샷은 없음으로 취급한다.
      return null;
    }
  }

  Future<void> clear() async {
    await _secureStore.delete(_accessTokenKey);
    await _secureStore.delete(_userKey);
  }
}

@Riverpod(keepAlive: true)
AuthTokenStore authTokenStore(Ref ref) =>
    AuthTokenStore(ref.watch(secureStoreProvider));
