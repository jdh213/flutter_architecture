import 'package:app_core/app_core.dart';
import 'package:app_mvi/app_mvi.dart';
import 'package:feature_example/src/domain/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_detail_state.freezed.dart';

@freezed
abstract class PostDetailState with _$PostDetailState implements MviState {
  const factory PostDetailState({
    @Default(true) bool isLoading,
    Post? post,
    @Default([]) List<Post> relatedPosts,
    AppException? error,
  }) = _PostDetailState;
}
