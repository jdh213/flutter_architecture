import 'dart:async';

import 'package:app_design_system/app_design_system.dart';
import 'package:app_l10n/app_l10n.dart';
import 'package:app_mvi/app_mvi.dart';
import 'package:feature_example/src/presentation/screens/post_detail/post_detail_screen.dart';
import 'package:feature_example/src/presentation/screens/post_list/post_list_effect.dart';
import 'package:feature_example/src/presentation/screens/post_list/post_list_intent.dart';
import 'package:feature_example/src/presentation/screens/post_list/post_list_state.dart';
import 'package:feature_example/src/presentation/screens/post_list/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 게시글 목록 화면 (View).
class PostListScreen extends ConsumerWidget {
  const PostListScreen({this.appBarActions = const [], super.key});

  static const String routePath = '/posts';

  /// composition root(앱)가 주입하는 앱바 액션.
  /// feature는 다른 feature(예: 로그아웃 = feature_auth)를 모르기 때문에,
  /// feature 간 연결이 필요한 UI는 앱이 이 파라미터로 조립한다.
  final List<Widget> appBarActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postListViewModelProvider);
    final viewModel = ref.read(postListViewModelProvider.notifier);

    return MviEffectListener<PostListEffect>(
      effects: viewModel.effects,
      onEffect: (context, effect) {
        switch (effect) {
          case PostListShowError(:final exception):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.localizedMessage(context.l10n)),
              ),
            );
          case PostListNavigateToDetail(:final postId):
            unawaited(context.push(PostDetailScreen.pathFor(postId)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.postsTitle),
          actions: appBarActions,
        ),
        body: _Body(state: state, viewModel: viewModel),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.viewModel});

  final PostListState state;
  final PostListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const AppLoadingView();
    }

    if (state.error != null && !state.hasData) {
      return AppErrorView(
        message: state.error!.localizedMessage(context.l10n),
        onRetry: () => viewModel.onIntent(const PostListRetryPressed()),
      );
    }

    return Column(
      children: [
        // RefreshIndicator의 onRefresh는 fire-and-forget intent라 스피너가
        // 즉시 사라진다 — 실제 진행 상태는 isRefreshing으로 표시한다.
        if (state.isRefreshing) const LinearProgressIndicator(minHeight: 2),
        if (state.isFromCache) const _OfflineBanner(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async =>
                viewModel.onIntent(const PostListRefreshed()),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.posts.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => viewModel.onIntent(PostListPostPressed(post.id)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    // 시맨틱 컬러 토큰(ThemeExtension) 사용 예 — 라이트/다크 자동 전환.
    final semanticColors = context.semanticColors;
    return Container(
      width: double.infinity,
      color: semanticColors.warning,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        context.l10n.offlineBanner,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: semanticColors.onWarning,
        ),
      ),
    );
  }
}
