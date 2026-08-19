import 'package:app_mvi/app_mvi.dart';
import 'package:feature_example/src/domain/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_list_state.freezed.dart';

/// 게시글 목록 화면의 단일 불변 상태.
///
/// 로딩/에러/데이터를 클래스로 쪼개지 않고 필드로 표현한다.
/// - 최초 로딩 실패 → [errorMessage] 세팅 (전체 에러 화면)
/// - 데이터 보유 중 새로고침 실패 → Effect로 스낵바만 (데이터 유지)
@freezed
abstract class PostListState with _$PostListState implements MviState {
  const factory PostListState({
    @Default(true) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default([]) List<Post> posts,
    @Default(false) bool isFromCache,
    String? errorMessage,
  }) = _PostListState;

  const PostListState._();

  bool get hasData => posts.isNotEmpty;
}
