import 'package:app_network/app_network.dart';
import 'package:dio/dio.dart';
import 'package:feature_example/src/data/post_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_api.g.dart';

/// 게시글 원격 데이터 소스.
///
/// 예외 처리는 하지 않는다 — DioException을 그대로 던지고
/// Repository의 safeApiCall이 `Result`로 변환한다.
class PostsApi {
  const PostsApi(this._dio);

  final Dio _dio;

  Future<List<PostDto>> fetchPosts() async {
    final response = await _dio.get<List<dynamic>>('/posts');
    return response.data!
        .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PostDto> fetchPost(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/posts/$id');
    return PostDto.fromJson(response.data!);
  }
}

@riverpod
PostsApi postsApi(Ref ref) => PostsApi(ref.watch(dioProvider));
