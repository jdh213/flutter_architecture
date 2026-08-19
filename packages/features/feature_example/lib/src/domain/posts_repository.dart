import 'package:app_core/app_core.dart';

import 'package:feature_example/src/domain/post.dart';

/// 목록 조회 결과. 오프라인 캐시에서 온 데이터인지 여부를 함께 전달해
/// UI가 오프라인 배너를 표시할 수 있게 한다.
class PostsSnapshot {
  const PostsSnapshot({required this.posts, required this.fromCache});

  final List<Post> posts;
  final bool fromCache;
}

abstract interface class PostsRepository {
  /// 네트워크 우선 조회. 실패 시 캐시로 폴백한다.
  Future<Result<PostsSnapshot>> fetchPosts();

  Future<Result<Post>> fetchPost(int id);
}
