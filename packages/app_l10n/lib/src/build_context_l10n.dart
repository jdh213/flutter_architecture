import 'package:app_l10n/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// `AppLocalizations.of(context)`의 축약형.
///
/// ```dart
/// Text(context.l10n.postsTitle)
/// ```
extension BuildContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
