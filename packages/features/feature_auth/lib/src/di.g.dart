// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// feature 내부 배선(조립) 파일.
///
/// provider 위치 규칙 (ADR-0005):
/// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
/// - **data 내부 전용 provider** (AuthApi, AuthTokenStore) → 구현 파일 옆.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// feature 내부 배선(조립) 파일.
///
/// provider 위치 규칙 (ADR-0005):
/// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
/// - **data 내부 전용 provider** (AuthApi, AuthTokenStore) → 구현 파일 옆.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// feature 내부 배선(조립) 파일.
  ///
  /// provider 위치 규칙 (ADR-0005):
  /// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
  /// - **data 내부 전용 provider** (AuthApi, AuthTokenStore) → 구현 파일 옆.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'cc4397f8d572a6992e5284b465d24b8f88d04f4a';
