import 'package:app_mvi/app_mvi.dart';

sealed class PostListIntent implements MviIntent {
  const PostListIntent();
}

/// pull-to-refresh.
final class PostListRefreshed extends PostListIntent {
  const PostListRefreshed();
}

/// 전체 에러 화면의 '다시 시도' 버튼.
final class PostListRetryPressed extends PostListIntent {
  const PostListRetryPressed();
}

/// 목록 항목 탭 → 상세로 이동.
final class PostListPostPressed extends PostListIntent {
  const PostListPostPressed(this.postId);

  final int postId;
}
