import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:app_mvi/app_mvi.dart';
import 'package:feature_example/src/data/posts_repository_impl.dart';
import 'package:feature_example/src/presentation/post_list/post_list_effect.dart';
import 'package:feature_example/src/presentation/post_list/post_list_intent.dart';
import 'package:feature_example/src/presentation/post_list/post_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_list_view_model.g.dart';

@riverpod
class PostListViewModel extends _$PostListViewModel
    with MviEffectEmitter<PostListEffect> {
  @override
  PostListState build() {
    ref.onDispose(disposeEffects);
    // build는 동기로 초기 상태만 반환하고, 초기 로드는 다음 microtask로 미룬다.
    unawaited(Future.microtask(_loadInitial));
    return const PostListState();
  }

  void onIntent(PostListIntent intent) {
    switch (intent) {
      case PostListRefreshed():
        unawaited(_refresh());
      case PostListRetryPressed():
        unawaited(_loadInitial());
      case PostListPostPressed(:final postId):
        emitEffect(PostListNavigateToDetail(postId));
    }
  }

  Future<void> _loadInitial() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await ref.read(postsRepositoryProvider).fetchPosts();
    if (!ref.mounted) return;

    state = result.fold(
      onSuccess: (snapshot) => state.copyWith(
        isLoading: false,
        posts: snapshot.posts,
        isFromCache: snapshot.fromCache,
      ),
      onFailure: (exception) => state.copyWith(
        isLoading: false,
        errorMessage: exception.message,
      ),
    );
  }

  Future<void> _refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);

    final result = await ref.read(postsRepositoryProvider).fetchPosts();
    if (!ref.mounted) return;

    switch (result) {
      case Success(:final value):
        state = state.copyWith(
          isRefreshing: false,
          posts: value.posts,
          isFromCache: value.fromCache,
        );
      case Failure(:final exception):
        // 이미 보여주고 있는 데이터는 유지하고 스낵바만 띄운다.
        state = state.copyWith(isRefreshing: false);
        emitEffect(PostListShowError(exception.message));
    }
  }
}
