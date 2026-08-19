import 'dart:async';

import 'package:feature_example/src/data/posts_repository_impl.dart';
import 'package:feature_example/src/presentation/post_detail/post_detail_intent.dart';
import 'package:feature_example/src/presentation/post_detail/post_detail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_detail_view_model.g.dart';

/// 파라미터(postId)를 받는 ViewModel — riverpod family 예시.
///
/// build의 파라미터가 provider의 family 인자가 된다:
/// `ref.watch(postDetailViewModelProvider(postId))`
@riverpod
class PostDetailViewModel extends _$PostDetailViewModel {
  @override
  PostDetailState build(int postId) {
    unawaited(Future.microtask(_load));
    return const PostDetailState();
  }

  void onIntent(PostDetailIntent intent) {
    switch (intent) {
      case PostDetailRetryPressed():
        unawaited(_load());
    }
  }

  Future<void> _load() async {
    state = const PostDetailState();

    final result = await ref.read(postsRepositoryProvider).fetchPost(postId);
    if (!ref.mounted) return;

    state = result.fold(
      onSuccess: (post) => PostDetailState(isLoading: false, post: post),
      onFailure: (exception) => PostDetailState(
        isLoading: false,
        errorMessage: exception.message,
      ),
    );
  }
}
