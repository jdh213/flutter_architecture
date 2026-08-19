import 'package:app_core/app_core.dart';
import 'package:app_network/app_network.dart';
import 'package:app_storage/app_storage.dart';
import 'package:feature_example/src/data/datasources/remote/posts_api.dart';
import 'package:feature_example/src/data/dtos/post_dto.dart';
import 'package:feature_example/src/domain/entities/post.dart';
import 'package:feature_example/src/domain/repositories/posts_repository.dart';

/// 네트워크 우선 + 오프라인 캐시 폴백 Repository.
///
/// - 네트워크 성공 → 캐시 갱신 후 반환
/// - 네트워크 실패 → 캐시가 있으면 fromCache=true로 반환, 없으면 실패 전파
class PostsRepositoryImpl implements PostsRepository {
  const PostsRepositoryImpl({
    required this._api,
    required this._cache,
  });

  static const String _cacheKey = 'posts.list';
  static const Duration _cacheMaxAge = Duration(days: 1);

  final PostsApi _api;
  final JsonCacheStore _cache;

  @override
  Future<Result<PostsSnapshot>> fetchPosts() async {
    final result = await safeApiCall(_api.fetchPosts);

    switch (result) {
      case Success(:final value):
        await _updateCacheOrIgnore(value);
        return Result.success(
          PostsSnapshot(
            posts: value.map((e) => e.toDomain()).toList(),
            fromCache: false,
          ),
        );

      case Failure(:final exception):
        final cached = await _readCacheOrNull();
        if (cached != null) {
          return Result.success(
            PostsSnapshot(posts: cached, fromCache: true),
          );
        }
        return Result.failure(exception);
    }
  }

  @override
  Future<Result<Post>> fetchPost(int id) => safeApiCall(
    () async => (await _api.fetchPost(id)).toDomain(),
  );

  /// 캐시는 부가 기능이다 — 쓰기 실패(디스크 풀, DB 잠김 등)가
  /// 성공한 네트워크 응답을 망치거나 Repository의 'throw 금지' 계약을
  /// 뚫으면 안 되므로 여기서 삼킨다.
  Future<void> _updateCacheOrIgnore(List<PostDto> dtos) async {
    try {
      await _cache.put(_cacheKey, dtos.map((e) => e.toJson()).toList());
    } on Exception {
      // 무시 — 다음 성공 응답에서 다시 시도된다.
    }
  }

  Future<List<Post>?> _readCacheOrNull() async {
    try {
      final dtos = await _cache.get(
        _cacheKey,
        maxAge: _cacheMaxAge,
        decode: (json) => (json! as List<dynamic>)
            .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
      return dtos?.map((e) => e.toDomain()).toList();
    } on Exception {
      // 캐시 손상/저장소 장애는 폴백 실패(캐시 없음)로만 취급한다.
      return null;
    }
  }
}
