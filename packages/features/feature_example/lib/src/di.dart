import 'package:feature_example/src/data/posts_repository_impl.dart';
import 'package:feature_example/src/domain/usecases/get_post_detail_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

/// feature 내부 배선(조립) 파일.
///
/// provider의 위치 규칙: "그 타입을 만들 줄 아는 가장 안쪽 파일"에 둔다.
/// - Repository provider → 구현 파일 옆 (data 계층)
/// - UseCase provider → UseCase 클래스는 domain(순수)에 있지만 배선에는
///   data의 repository provider가 필요하다. domain이 data를 import 하면
///   의존성 규칙 위반이므로, 배선만 이 파일이 담당한다.
@riverpod
GetPostDetailUseCase getPostDetailUseCase(Ref ref) =>
    GetPostDetailUseCase(ref.watch(postsRepositoryProvider));
