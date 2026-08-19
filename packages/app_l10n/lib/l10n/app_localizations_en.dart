// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get retry => 'Retry';

  @override
  String get errorTimeout => 'The request timed out. Please try again shortly.';

  @override
  String get errorNoConnection => 'Please check your network connection.';

  @override
  String get errorUnauthorized =>
      'Your session has expired. Please sign in again.';

  @override
  String get errorForbidden => 'You don\'t have permission to access this.';

  @override
  String get errorNotFound => 'The requested information could not be found.';

  @override
  String get errorServer =>
      'A temporary server problem occurred. Please try again shortly.';

  @override
  String get errorCancelled => 'The request was cancelled.';

  @override
  String get errorNetwork => 'A network error occurred.';

  @override
  String get errorCache => 'Failed to read saved data.';

  @override
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get logoutTooltip => 'Sign out';

  @override
  String get postsTitle => 'Posts';

  @override
  String get postDetailTitle => 'Post detail';

  @override
  String get offlineBanner => 'Offline — showing saved data.';

  @override
  String get relatedPostsTitle => 'More from this author';
}
