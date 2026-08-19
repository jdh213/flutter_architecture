import 'package:feature_auth/src/data/datasources/local/auth_token_store.dart';
import 'package:feature_auth/src/data/datasources/remote/auth_api.dart';
import 'package:feature_auth/src/data/repositories/auth_repository_impl.dart';
import 'package:feature_auth/src/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

/// feature 내부 배선(조립) 파일.
///
/// provider 위치 규칙 (ADR-0005):
/// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
/// - **data 내부 전용 provider** (AuthApi, AuthTokenStore) → 구현 파일 옆.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  api: ref.watch(authApiProvider),
  tokenStore: ref.watch(authTokenStoreProvider),
);
