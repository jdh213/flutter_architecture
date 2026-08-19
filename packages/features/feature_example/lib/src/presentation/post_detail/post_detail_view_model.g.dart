// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
///
/// build의 파라미터가 provider의 family 인자가 된다:
/// `ref.watch(postDetailViewModelProvider(postId))`

@ProviderFor(PostDetailViewModel)
final postDetailViewModelProvider = PostDetailViewModelFamily._();

/// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
///
/// build의 파라미터가 provider의 family 인자가 된다:
/// `ref.watch(postDetailViewModelProvider(postId))`
final class PostDetailViewModelProvider
    extends $NotifierProvider<PostDetailViewModel, PostDetailState> {
  /// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
  ///
  /// build의 파라미터가 provider의 family 인자가 된다:
  /// `ref.watch(postDetailViewModelProvider(postId))`
  PostDetailViewModelProvider._({
    required PostDetailViewModelFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'postDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postDetailViewModelHash();

  @override
  String toString() {
    return r'postDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PostDetailViewModel create() => PostDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PostDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postDetailViewModelHash() =>
    r'72acdd18bab0482fa5691e1790ec2c2c415be6ef';

/// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
///
/// build의 파라미터가 provider의 family 인자가 된다:
/// `ref.watch(postDetailViewModelProvider(postId))`

final class PostDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          PostDetailViewModel,
          PostDetailState,
          PostDetailState,
          PostDetailState,
          int
        > {
  PostDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'postDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
  ///
  /// build의 파라미터가 provider의 family 인자가 된다:
  /// `ref.watch(postDetailViewModelProvider(postId))`

  PostDetailViewModelProvider call(int postId) =>
      PostDetailViewModelProvider._(argument: postId, from: this);

  @override
  String toString() => r'postDetailViewModelProvider';
}

/// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
///
/// build의 파라미터가 provider의 family 인자가 된다:
/// `ref.watch(postDetailViewModelProvider(postId))`

abstract class _$PostDetailViewModel extends $Notifier<PostDetailState> {
  late final _$args = ref.$arg as int;
  int get postId => _$args;

  PostDetailState build(int postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PostDetailState, PostDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostDetailState, PostDetailState>,
              PostDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
