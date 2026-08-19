import 'package:dio/dio.dart';
import 'package:feature_auth/src/domain/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_api.g.dart';

/// 로그인 성공 응답.
class AuthSession {
  const AuthSession({required this.accessToken, required this.user});

  final String accessToken;
  final AuthUser user;
}

/// 인증 API 계약.
abstract interface class AuthApi {
  Future<AuthSession> login({required String email, required String password});

  /// 토큰으로 현재 사용자 정보를 조회한다.
  Future<AuthUser> me();
}

/// 실서버가 없는 템플릿 상태에서 인증 플로우 전체를 시연하기 위한 가짜 구현.
///
/// 실서버 연동 시 [authApiProvider]에서 [RemoteAuthApi]로 교체한다.
class FakeAuthApi implements AuthApi {
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return AuthSession(
      accessToken: 'fake-access-token',
      user: AuthUser(id: '1', name: '홍길동', email: email),
    );
  }

  @override
  Future<AuthUser> me() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const AuthUser(id: '1', name: '홍길동', email: 'hong@example.com');
  }
}

/// 실서버 구현 예시. 엔드포인트를 실제 서버 스펙에 맞게 수정해 사용한다.
class RemoteAuthApi implements AuthApi {
  const RemoteAuthApi(this._dio);

  final Dio _dio;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = response.data!;
    final userJson = data['user'] as Map<String, dynamic>;
    return AuthSession(
      accessToken: data['accessToken'] as String,
      user: AuthUser(
        id: userJson['id'].toString(),
        name: userJson['name'] as String,
        email: userJson['email'] as String,
      ),
    );
  }

  @override
  Future<AuthUser> me() async {
    final response = await _dio.get<Map<String, dynamic>>('/auth/me');
    final data = response.data!;
    return AuthUser(
      id: data['id'].toString(),
      name: data['name'] as String,
      email: data['email'] as String,
    );
  }
}

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) {
  // 실서버 연동 시: return RemoteAuthApi(ref.watch(dioProvider));
  // dioProvider를 watch 하면 인터셉터(토큰 첨부/401 처리)가 자동 적용된다.
  return FakeAuthApi();
}
