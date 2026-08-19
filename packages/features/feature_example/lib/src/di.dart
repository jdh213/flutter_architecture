import 'package:app_storage/app_storage.dart';
import 'package:feature_example/src/data/posts_api.dart';
import 'package:feature_example/src/data/posts_repository_impl.dart';
import 'package:feature_example/src/domain/posts_repository.dart';
import 'package:feature_example/src/domain/usecases/get_post_detail_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

/// feature 내부 배선(조립) 파일.
///
/// provider 위치 규칙 (ADR-0005):
/// - **경계 provider** (presentation이 참조하는 Repository/UseCase) → 이 파일.
///   presentation이 data 구현 파일을 import 하지 않게 되어 계층 규칙이
///   import 방향에서도 지켜진다.
/// - **data 내부 전용 provider** (API 클라이언트 등) → 구현 파일 옆.
@riverpod
PostsRepository postsRepository(Ref ref) => PostsRepositoryImpl(
  api: ref.watch(postsApiProvider),
  cache: ref.watch(jsonCacheStoreProvider),
);

@riverpod
GetPostDetailUseCase getPostDetailUseCase(Ref ref) =>
    GetPostDetailUseCase(ref.watch(postsRepositoryProvider));
