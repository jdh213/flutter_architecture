import 'package:app_core/app_core.dart';
import 'package:feature_example/src/domain/entities/post.dart';
import 'package:feature_example/src/domain/repositories/posts_repository.dart';
import 'package:feature_example/src/domain/usecases/get_post_detail_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  Post post(int id, {int userId = 10}) =>
      Post(id: id, userId: userId, title: '제목$id', body: '본문$id');

  const failure = Result<PostsSnapshot>.failure(
    NetworkException(message: '네트워크 오류', type: NetworkErrorType.noConnection),
  );

  late MockPostsRepository repository;
  late GetPostDetailUseCase useCase;

  setUp(() {
    repository = MockPostsRepository();
    useCase = GetPostDetailUseCase(repository);
  });

  test('같은 작성자의 다른 글만 최대 3개 골라낸다 (자기 자신 제외)', () async {
    when(
      () => repository.fetchPost(1),
    ).thenAnswer((_) async => Result.success(post(1)));
    when(repository.fetchPosts).thenAnswer(
      (_) async => Result.success(
        PostsSnapshot(
          posts: [
            post(1), // 자기 자신 → 제외
            post(2),
            post(3),
            post(4),
            post(5), // 4번째 같은 작성자 글 → 최대 3개 제한으로 제외
            post(6, userId: 20), // 다른 작성자 → 제외
          ],
          fromCache: false,
        ),
      ),
    );

    final result = await useCase.call(1);

    final bundle = result.valueOrNull!;
    expect(bundle.post.id, 1);
    expect(bundle.relatedPosts.map((p) => p.id), [2, 3, 4]);
  });

  test('관련 글 조회 실패는 부분 실패로 취급한다 — 상세는 성공, 관련 글은 빈 목록', () async {
    when(
      () => repository.fetchPost(1),
    ).thenAnswer((_) async => Result.success(post(1)));
    when(repository.fetchPosts).thenAnswer((_) async => failure);

    final result = await useCase.call(1);

    final bundle = result.valueOrNull!;
    expect(bundle.post.id, 1);
    expect(bundle.relatedPosts, isEmpty);
  });

  test('상세 조회 실패는 전체 실패로 전파된다', () async {
    when(() => repository.fetchPost(1)).thenAnswer(
      (_) async => const Result.failure(
        NetworkException(message: '찾을 수 없음', type: NetworkErrorType.notFound),
      ),
    );
    when(repository.fetchPosts).thenAnswer(
      (_) async => const Result.success(
        PostsSnapshot(posts: [], fromCache: false),
      ),
    );

    final result = await useCase.call(1);

    expect(result.exceptionOrNull, isA<NetworkException>());
  });
}
