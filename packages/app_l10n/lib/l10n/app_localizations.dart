import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @retry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get retry;

  /// No description provided for @errorTimeout.
  ///
  /// In ko, this message translates to:
  /// **'요청 시간이 초과되었습니다. 잠시 후 다시 시도해주세요.'**
  String get errorTimeout;

  /// No description provided for @errorNoConnection.
  ///
  /// In ko, this message translates to:
  /// **'네트워크 연결을 확인해주세요.'**
  String get errorNoConnection;

  /// No description provided for @errorUnauthorized.
  ///
  /// In ko, this message translates to:
  /// **'로그인이 만료되었습니다. 다시 로그인해주세요.'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In ko, this message translates to:
  /// **'접근 권한이 없습니다.'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In ko, this message translates to:
  /// **'요청한 정보를 찾을 수 없습니다.'**
  String get errorNotFound;

  /// No description provided for @errorServer.
  ///
  /// In ko, this message translates to:
  /// **'서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요.'**
  String get errorServer;

  /// No description provided for @errorCancelled.
  ///
  /// In ko, this message translates to:
  /// **'요청이 취소되었습니다.'**
  String get errorCancelled;

  /// No description provided for @errorNetwork.
  ///
  /// In ko, this message translates to:
  /// **'네트워크 오류가 발생했습니다.'**
  String get errorNetwork;

  /// No description provided for @errorCache.
  ///
  /// In ko, this message translates to:
  /// **'저장된 데이터를 읽는 중 오류가 발생했습니다.'**
  String get errorCache;

  /// No description provided for @errorUnknown.
  ///
  /// In ko, this message translates to:
  /// **'알 수 없는 오류가 발생했습니다.'**
  String get errorUnknown;

  /// No description provided for @loginTitle.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In ko, this message translates to:
  /// **'이메일'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get loginButton;

  /// No description provided for @logoutTooltip.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get logoutTooltip;

  /// No description provided for @postsTitle.
  ///
  /// In ko, this message translates to:
  /// **'게시글'**
  String get postsTitle;

  /// No description provided for @postDetailTitle.
  ///
  /// In ko, this message translates to:
  /// **'게시글 상세'**
  String get postDetailTitle;

  /// No description provided for @offlineBanner.
  ///
  /// In ko, this message translates to:
  /// **'오프라인 — 저장된 데이터를 표시하고 있습니다.'**
  String get offlineBanner;

  /// No description provided for @relatedPostsTitle.
  ///
  /// In ko, this message translates to:
  /// **'같은 작성자의 다른 글'**
  String get relatedPostsTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
