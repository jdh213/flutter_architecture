// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostListViewModel)
final postListViewModelProvider = PostListViewModelProvider._();

final class PostListViewModelProvider
    extends $NotifierProvider<PostListViewModel, PostListState> {
  PostListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postListViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postListViewModelHash();

  @$internal
  @override
  PostListViewModel create() => PostListViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostListState>(value),
    );
  }
}

String _$postListViewModelHash() => r'4340ed6ad7abd5487c61596504b01ca0a96abf05';

abstract class _$PostListViewModel extends $Notifier<PostListState> {
  PostListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PostListState, PostListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostListState, PostListState>,
              PostListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
