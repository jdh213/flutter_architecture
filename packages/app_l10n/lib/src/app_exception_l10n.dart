import 'package:app_core/app_core.dart';

import 'package:app_l10n/l10n/app_localizations.dart';

/// [AppException] → 사용자 노출 문구 매핑.
///
/// 인프라 계층(app_network/app_storage)은 실패의 **종류**만 책임지고,
/// 사용자에게 보여줄 **문구**는 여기(표현 계층)에서 로케일에 맞게 결정한다.
/// State/Effect에는 문자열이 아니라 [AppException]을 담고,
/// View가 이 확장으로 변환한다.
extension AppExceptionL10n on AppException {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
    NetworkException(:final type) => switch (type) {
      NetworkErrorType.timeout => l10n.errorTimeout,
      NetworkErrorType.noConnection => l10n.errorNoConnection,
      NetworkErrorType.unauthorized => l10n.errorUnauthorized,
      NetworkErrorType.forbidden => l10n.errorForbidden,
      NetworkErrorType.notFound => l10n.errorNotFound,
      NetworkErrorType.server => l10n.errorServer,
      NetworkErrorType.cancelled => l10n.errorCancelled,
      NetworkErrorType.unknown => l10n.errorNetwork,
    },
    CacheException() => l10n.errorCache,
    // 도메인 검증 문구는 feature가 생성 시점에 l10n으로 만들어 담는다.
    ValidationException(:final message) => message,
    UnknownException() => l10n.errorUnknown,
  };
}
