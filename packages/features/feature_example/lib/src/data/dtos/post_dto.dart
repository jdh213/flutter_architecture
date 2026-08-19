import 'package:feature_example/src/domain/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// 게시글 API 응답 DTO.
///
/// 서버 스키마 변경의 영향 범위를 data 계층 안에 가둔다.
/// presentation은 [Post] 엔티티만 보므로 서버 필드명이 바뀌어도
/// 이 파일과 매핑만 수정하면 된다.
@freezed
abstract class PostDto with _$PostDto {
  const factory PostDto({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostDto;

  const PostDto._();

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Post toDomain() => Post(id: id, userId: userId, title: title, body: body);
}
