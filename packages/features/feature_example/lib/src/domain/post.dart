import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// 게시글 도메인 엔티티.
///
/// domain 계층은 JSON 직렬화를 모른다 — 그것은 data 계층 DTO의 책임이다.
@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _Post;
}
