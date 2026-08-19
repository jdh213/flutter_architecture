import 'package:app_core/app_core.dart';
import 'package:app_network/src/exception_mapper.dart';
import 'package:dio/dio.dart';

/// API 호출을 [Result]로 감싸는 표준 헬퍼.
///
/// 데이터 소스(remote data source)의 모든 메서드는 이 헬퍼를 통해
/// Repository에 [Result]를 반환한다:
///
/// ```dart
/// Future<Result<List<PostDto>>> fetchPosts() => safeApiCall(() async {
///       final response = await _dio.get<List<dynamic>>('/posts');
///       return response.data!
///           .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
///           .toList();
///     });
/// ```
Future<Result<T>> safeApiCall<T>(Future<T> Function() call) => Result.guard(
  call,
  mapError: (error, stackTrace) => switch (error) {
    DioException() => mapDioException(error, stackTrace),
    _ => null,
  },
);
