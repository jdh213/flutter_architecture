import 'package:app_core/app_core.dart';
import 'package:app_storage/app_storage.dart';
import 'package:dio/dio.dart';
import 'package:feature_auth/src/data/datasources/local/auth_token_store.dart';
import 'package:feature_auth/src/data/datasources/remote/auth_api.dart';
import 'package:feature_auth/src/data/repositories/auth_repository_impl.dart';
import 'package:feature_auth/src/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthApi extends Mock implements AuthApi {}

void main() {
  const user = AuthUser(id: '1', name: '홍길동', email: 'a@b.c');

  late AuthTokenStore tokenStore;
  late MockAuthApi api;
  late AuthRepositoryImpl repository;

  setUp(() {
    tokenStore = AuthTokenStore(InMemorySecureStore());
    api = MockAuthApi();
    repository = AuthRepositoryImpl(api: api, tokenStore: tokenStore);
  });

  DioException dioError(int? statusCode, DioExceptionType type) {
    final options = RequestOptions(path: '/auth/me');
    return DioException(
      requestOptions: options,
      type: type,
      response: statusCode == null
          ? null
          : Response<void>(requestOptions: options, statusCode: statusCode),
    );
  }

  group('restoreSession', () {
    test('me() 401이면 세션을 폐기하고 Success(null)을 반환한다', () async {
      await tokenStore.saveAccessToken('stale-token');
      await tokenStore.saveUser(user);
      when(api.me).thenThrow(dioError(401, DioExceptionType.badResponse));

      final result = await repository.restoreSession();

      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull, isNull);
      expect(await tokenStore.readAccessToken(), isNull, reason: '토큰 폐기');
      expect(await tokenStore.readUser(), isNull, reason: '프로필 폐기');
    });

    test('일시 장애(오프라인)면 저장된 프로필 스냅샷으로 복원한다', () async {
      await tokenStore.saveAccessToken('valid-token');
      await tokenStore.saveUser(user);
      when(api.me).thenThrow(dioError(null, DioExceptionType.connectionError));

      final result = await repository.restoreSession();

      expect(result.valueOrNull?.id, '1');
      expect(
        await tokenStore.readAccessToken(),
        'valid-token',
        reason: '일시 장애로 세션을 파괴하지 않는다',
      );
    });

    test('일시 장애 + 스냅샷 없음(최초 실행)이면 Failure를 전파한다', () async {
      await tokenStore.saveAccessToken('valid-token');
      when(api.me).thenThrow(dioError(null, DioExceptionType.connectionError));

      final result = await repository.restoreSession();

      expect(
        result.exceptionOrNull,
        isA<NetworkException>().having(
          (e) => e.type,
          'type',
          NetworkErrorType.noConnection,
        ),
      );
    });

    test('me() 성공 시 프로필 스냅샷을 갱신한다', () async {
      const renamed = AuthUser(id: '1', name: '새이름', email: 'a@b.c');
      await tokenStore.saveAccessToken('valid-token');
      await tokenStore.saveUser(user);
      when(api.me).thenAnswer((_) async => renamed);

      final result = await repository.restoreSession();

      expect(result.valueOrNull?.name, '새이름');
      expect((await tokenStore.readUser())?.name, '새이름');
    });
  });

  test('login은 토큰과 프로필 스냅샷을 함께 저장한다', () async {
    when(
      () => api.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const AuthSession(accessToken: 'token-1', user: user),
    );

    await repository.login(email: 'a@b.c', password: 'pw');

    expect(await tokenStore.readAccessToken(), 'token-1');
    expect((await tokenStore.readUser())?.email, 'a@b.c');
  });
}
