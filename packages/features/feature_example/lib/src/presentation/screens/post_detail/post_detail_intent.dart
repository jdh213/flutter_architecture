import 'package:app_mvi/app_mvi.dart';

/// 상세 화면의 사용자 의도.
///
/// 이 화면은 Effect가 없다 — Effect가 없는 화면은 effect 파일을 생략한다.
sealed class PostDetailIntent implements MviIntent {
  const PostDetailIntent();
}

final class PostDetailRetryPressed extends PostDetailIntent {
  const PostDetailRetryPressed();
}
