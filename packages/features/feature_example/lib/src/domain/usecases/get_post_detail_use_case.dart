import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:feature_example/src/domain/post.dart';
import 'package:feature_example/src/domain/posts_repository.dart';

/// 게시글 상세 화면에 필요한 데이터 묶음.
class PostDetailBundle {
  const PostDetailBundle({required this.post, required this.relatedPosts});

  final Post post;

  /// 같은 작성자의 다른 글 (최대 3개). 조회 실패 시 빈 목록 — 부분 실패 정책.
  final List<Post> relatedPosts;
}

/// UseCase 도입 조건을 시연하는 예제 (ADR-0005 참고).
///
/// 이 템플릿의 기본은 ViewModel → Repository 직행이다. UseCase는 아래 조건이
/// 생길 때만 추가하며, 이 클래스는 그 조건을 실제로 충족한다:
/// - **조합**: 상세 조회 + 목록 조회를 병렬 실행해 하나의 결과로 합친다
/// - **도메인 규칙**: "같은 작성자 / 자기 자신 제외 / 최대 3개"는
///   ViewModel(표현)도 Repository(데이터 접근)도 아닌 도메인의 규칙이다
/// - **부분 실패 정책**: 상세 실패는 전체 실패, 관련 글 실패는 무시(빈 목록)
///
/// 단순 위임만 하는 pass-through UseCase는 만들지 않는다.
class GetPostDetailUseCase {
  const GetPostDetailUseCase(this._repository);

  static const int _maxRelatedPosts = 3;

  final PostsRepository _repository;

  Future<Result<PostDetailBundle>> call(int postId) async {
    // Dart 3 record.wait — 두 조회를 병렬로 실행한다.
    final (postResult, listResult) = await (
      _repository.fetchPost(postId),
      _repository.fetchPosts(),
    ).wait;

    return postResult.map((post) {
      final relatedPosts = listResult.fold(
        onSuccess: (snapshot) => snapshot.posts
            .where((p) => p.userId == post.userId && p.id != post.id)
            .take(_maxRelatedPosts)
            .toList(),
        // 관련 글은 부가 정보이므로 실패해도 상세 화면을 막지 않는다.
        onFailure: (_) => const <Post>[],
      );
      return PostDetailBundle(post: post, relatedPosts: relatedPosts);
    });
  }
}
