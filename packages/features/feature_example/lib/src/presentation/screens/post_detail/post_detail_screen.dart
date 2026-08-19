import 'package:app_design_system/app_design_system.dart';
import 'package:app_l10n/app_l10n.dart';
import 'package:feature_example/src/presentation/screens/post_detail/post_detail_intent.dart';
import 'package:feature_example/src/presentation/screens/post_detail/post_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 게시글 상세 화면 (View).
class PostDetailScreen extends ConsumerWidget {
  const PostDetailScreen({required this.postId, super.key});

  static const String routePath = '/posts/:postId';

  static String pathFor(int postId) => '/posts/$postId';

  final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postDetailViewModelProvider(postId));
    final viewModel = ref.read(postDetailViewModelProvider(postId).notifier);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.postDetailTitle)),
      body: switch (state) {
        _ when state.isLoading => const AppLoadingView(),
        _ when state.error != null => AppErrorView(
          message: state.error!.localizedMessage(context.l10n),
          onRetry: () => viewModel.onIntent(const PostDetailRetryPressed()),
        ),
        _ => SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.post!.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const AppGap.lg(),
              Text(
                state.post!.body,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // 관련 글은 UseCase의 부분 실패 정책에 따라
              // 조회 실패 시 빈 목록이 되어 섹션 자체가 사라진다.
              if (state.relatedPosts.isNotEmpty) ...[
                const AppGap.xl(),
                Text(
                  context.l10n.relatedPostsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const AppGap.sm(),
                for (final related in state.relatedPosts)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xs,
                    ),
                    child: Text(
                      '• ${related.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
              ],
            ],
          ),
        ),
      },
    );
  }
}
