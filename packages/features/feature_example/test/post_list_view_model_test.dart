import 'package:app_core/app_core.dart';
import 'package:feature_example/src/di.dart';
import 'package:feature_example/src/domain/entities/post.dart';
import 'package:feature_example/src/domain/repositories/posts_repository.dart';
import 'package:feature_example/src/presentation/post_list/post_list_effect.dart';
import 'package:feature_example/src/presentation/post_list/post_list_intent.dart';
import 'package:feature_example/src/presentation/post_list/post_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  const post = Post(id: 1, userId: 1, title: '제목', body: '본문');
  const snapshot = PostsSnapshot(posts: [post], fromCache: false);
  const failure = Result<PostsSnapshot>.failure(
    NetworkException(message: '네트워크 오류', type: NetworkErrorType.noConnection),
  );

  late MockPostsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = MockPostsRepository();
    container = ProviderContainer(
      overrides: [
        postsRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    addTearDown(container.dispose);
  });

  test('초기 로드 성공 시 posts를 채운다', () async {
    when(
      repository.fetchPosts,
    ).thenAnswer((_) async => const Result.success(snapshot));

    container.listen(postListViewModelProvider, (_, _) {});
    await pumpEventQueue();

    final state = container.read(postListViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.posts, [post]);
    expect(state.error, isNull);
  });

  test('초기 로드 실패 시 error를 세팅한다', () async {
    when(repository.fetchPosts).thenAnswer((_) async => failure);

    container.listen(postListViewModelProvider, (_, _) {});
    await pumpEventQueue();

    final state = container.read(postListViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.error?.message, '네트워크 오류');
  });

  test('새로고침 실패 시 기존 데이터를 유지하고 에러 Effect만 방출한다', () async {
    when(
      repository.fetchPosts,
    ).thenAnswer((_) async => const Result.success(snapshot));

    container.listen(postListViewModelProvider, (_, _) {});
    await pumpEventQueue();

    final viewModel = container.read(postListViewModelProvider.notifier);
    final effects = <PostListEffect>[];
    final subscription = viewModel.effects.listen(effects.add);
    addTearDown(subscription.cancel);

    when(repository.fetchPosts).thenAnswer((_) async => failure);
    viewModel.onIntent(const PostListRefreshed());
    await pumpEventQueue();

    final state = container.read(postListViewModelProvider);
    expect(state.posts, [post], reason: '실패해도 기존 데이터를 유지한다');
    expect(state.isRefreshing, isFalse);
    expect(effects.single, isA<PostListShowError>());
  });

  test('항목 탭 intent는 상세 이동 Effect를 방출한다', () async {
    when(
      repository.fetchPosts,
    ).thenAnswer((_) async => const Result.success(snapshot));

    container.listen(postListViewModelProvider, (_, _) {});
    final viewModel = container.read(postListViewModelProvider.notifier);

    final effects = <PostListEffect>[];
    final subscription = viewModel.effects.listen(effects.add);
    addTearDown(subscription.cancel);

    viewModel.onIntent(const PostListPostPressed(7));
    await pumpEventQueue();

    expect(
      effects.single,
      isA<PostListNavigateToDetail>().having((e) => e.postId, 'postId', 7),
    );
  });
}
