import 'dart:async';

import 'package:feature_example/src/di.dart';
import 'package:feature_example/src/presentation/screens/post_detail/post_detail_intent.dart';
import 'package:feature_example/src/presentation/screens/post_detail/post_detail_state.dart';
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

    // 조합/도메인 규칙이 필요한 조회라 Repository 직행 대신 UseCase를 쓴다
    // (도입 기준: ADR-0005).
    final result = await ref.read(getPostDetailUseCaseProvider).call(postId);
    if (!ref.mounted) return;

    state = result.fold(
      onSuccess: (bundle) => PostDetailState(
        isLoading: false,
        post: bundle.post,
        relatedPosts: bundle.relatedPosts,
      ),
      onFailure: (exception) => PostDetailState(
        isLoading: false,
        error: exception,
      ),
    );
  }
}
