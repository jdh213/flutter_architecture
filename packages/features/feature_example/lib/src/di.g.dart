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
///   presentation이 data 구현 파일을 import 하지 않게 되어 계층 규칙이
///   import 방향에서도 지켜진다.
/// - **data 내부 전용 provider** (API 클라이언트 등) → 구현 파일 옆.

@ProviderFor(postsRepository)
final postsRepositoryProvider = PostsRepositoryProvider._();

/// feature 내부 배선(조립) 파일.
///
/// provider 위치 규칙 (ADR-0005):
/// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
///   presentation이 data 구현 파일을 import 하지 않게 되어 계층 규칙이
///   import 방향에서도 지켜진다.
/// - **data 내부 전용 provider** (API 클라이언트 등) → 구현 파일 옆.

final class PostsRepositoryProvider
    extends
        $FunctionalProvider<PostsRepository, PostsRepository, PostsRepository>
    with $Provider<PostsRepository> {
  /// feature 내부 배선(조립) 파일.
  ///
  /// provider 위치 규칙 (ADR-0005):
  /// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
  ///   presentation이 data 구현 파일을 import 하지 않게 되어 계층 규칙이
  ///   import 방향에서도 지켜진다.
  /// - **data 내부 전용 provider** (API 클라이언트 등) → 구현 파일 옆.
  PostsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostsRepository create(Ref ref) {
    return postsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsRepository>(value),
    );
  }
}

String _$postsRepositoryHash() => r'b04397e811b2494aa1ee7889f6d5bda7cefb522a';

@ProviderFor(getPostDetailUseCase)
final getPostDetailUseCaseProvider = GetPostDetailUseCaseProvider._();

final class GetPostDetailUseCaseProvider
    extends
        $FunctionalProvider<
          GetPostDetailUseCase,
          GetPostDetailUseCase,
          GetPostDetailUseCase
        >
    with $Provider<GetPostDetailUseCase> {
  GetPostDetailUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPostDetailUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPostDetailUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPostDetailUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPostDetailUseCase create(Ref ref) {
    return getPostDetailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPostDetailUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPostDetailUseCase>(value),
    );
  }
}

String _$getPostDetailUseCaseHash() =>
    r'a3fe633a25f67a9cb1853471a9f7b4a614900183';
