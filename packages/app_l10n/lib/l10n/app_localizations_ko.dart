// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get retry => '다시 시도';

  @override
  String get errorTimeout => '요청 시간이 초과되었습니다. 잠시 후 다시 시도해주세요.';

  @override
  String get errorNoConnection => '네트워크 연결을 확인해주세요.';

  @override
  String get errorUnauthorized => '로그인이 만료되었습니다. 다시 로그인해주세요.';

  @override
  String get errorForbidden => '접근 권한이 없습니다.';

  @override
  String get errorNotFound => '요청한 정보를 찾을 수 없습니다.';

  @override
  String get errorServer => '서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요.';

  @override
  String get errorCancelled => '요청이 취소되었습니다.';

  @override
  String get errorNetwork => '네트워크 오류가 발생했습니다.';

  @override
  String get errorCache => '저장된 데이터를 읽는 중 오류가 발생했습니다.';

  @override
  String get errorUnknown => '알 수 없는 오류가 발생했습니다.';

  @override
  String get loginTitle => '로그인';

  @override
  String get emailLabel => '이메일';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get logoutTooltip => '로그아웃';

  @override
  String get postsTitle => '게시글';

  @override
  String get postDetailTitle => '게시글 상세';

  @override
  String get offlineBanner => '오프라인 — 저장된 데이터를 표시하고 있습니다.';

  @override
  String get relatedPostsTitle => '같은 작성자의 다른 글';
}
