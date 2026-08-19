import 'package:app_design_system/app_design_system.dart';
import 'package:feature_example/src/presentation/post_detail/post_detail_intent.dart';
import 'package:feature_example/src/presentation/post_detail/post_detail_view_model.dart';
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
      appBar: AppBar(title: const Text('게시글 상세')),
      body: switch (state) {
        _ when state.isLoading => const AppLoadingView(),
        _ when state.errorMessage != null => AppErrorView(
          message: state.errorMessage!,
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
            ],
          ),
        ),
      },
    );
  }
}
