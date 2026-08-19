import 'package:app_core/app_core.dart';
import 'package:app_storage/app_storage.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:feature_example/src/data/datasources/remote/posts_api.dart';
import 'package:feature_example/src/data/dtos/post_dto.dart';
import 'package:feature_example/src/data/repositories/posts_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsApi extends Mock implements PostsApi {}

void main() {
  const dto = PostDto(id: 1, userId: 1, title: '제목', body: '본문');

  late AppDatabase db;
  late MockPostsApi api;
  late PostsRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    api = MockPostsApi();
    repository = PostsRepositoryImpl(api: api, cache: JsonCacheStore(db));
  });

  tearDown(() async {
    await db.close();
  });

  DioException networkError() => DioException(
    requestOptions: RequestOptions(path: '/posts'),
    type: DioExceptionType.connectionError,
  );

  test('네트워크 성공 시 fromCache=false로 반환하고 캐시를 갱신한다', () async {
    when(api.fetchPosts).thenAnswer((_) async => [dto]);

    final result = await repository.fetchPosts();

    final snapshot = result.valueOrNull!;
    expect(snapshot.fromCache, isFalse);
    expect(snapshot.posts.single.title, '제목');

    // 이후 네트워크가 끊겨도 방금 저장된 캐시로 응답할 수 있어야 한다.
    when(api.fetchPosts).thenThrow(networkError());
    final fallback = await repository.fetchPosts();
    expect(fallback.valueOrNull!.fromCache, isTrue);
    expect(fallback.valueOrNull!.posts.single.title, '제목');
  });

  test('네트워크 실패 + 캐시 없음이면 NetworkException Failure를 반환한다', () async {
    when(api.fetchPosts).thenThrow(networkError());

    final result = await repository.fetchPosts();

    expect(result.exceptionOrNull, isA<NetworkException>());
  });

  test('fetchPost는 단건을 도메인 엔티티로 변환한다', () async {
    when(() => api.fetchPost(1)).thenAnswer((_) async => dto);

    final result = await repository.fetchPost(1);

    expect(result.valueOrNull!.id, 1);
  });
}
