import 'package:app_core/app_core.dart';
import 'package:app_mvi/app_mvi.dart';

sealed class PostListEffect implements MviEffect {
  const PostListEffect();
}

/// 데이터를 유지한 채 새로고침만 실패했을 때의 스낵바.
///
/// 문자열이 아니라 [AppException]을 담는다 — 사용자 문구는 View가
/// `localizedMessage(context.l10n)`로 만든다.
final class PostListShowError extends PostListEffect {
  const PostListShowError(this.exception);

  final AppException exception;
}

/// 상세 화면 이동. ViewModel은 라우터를 모르므로 Effect로 위임하고
/// View의 onEffect에서 context.push를 실행한다.
final class PostListNavigateToDetail extends PostListEffect {
  const PostListNavigateToDetail(this.postId);

  final int postId;
}
