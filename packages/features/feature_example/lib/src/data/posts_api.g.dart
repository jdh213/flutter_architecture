// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postsApi)
final postsApiProvider = PostsApiProvider._();

final class PostsApiProvider
    extends $FunctionalProvider<PostsApi, PostsApi, PostsApi>
    with $Provider<PostsApi> {
  PostsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsApiHash();

  @$internal
  @override
  $ProviderElement<PostsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostsApi create(Ref ref) {
    return postsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsApi>(value),
    );
  }
}

String _$postsApiHash() => r'4c9074f8d21e962fb47958a20ced0903e585fe4f';
