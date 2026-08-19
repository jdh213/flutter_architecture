/// 공용 국제화(l10n) 계층.
///
/// - ARB 리소스: `lib/l10n/app_ko.arb`(템플릿) / `app_en.arb`
/// - 문자열 추가 절차: 두 ARB에 키 추가 → `flutter gen-l10n` (scripts/gen.sh에 포함)
/// - 사용: 위젯에서 `context.l10n.postsTitle`
/// - 예외 → 사용자 문구 매핑: `exception.localizedMessage(context.l10n)`
///
/// 규칙: 사용자에게 노출되는 문자열을 위젯/상태/예외에 하드코딩하지 않는다.
/// `AppException.message`는 개발자용(로그) 설명이며 UI에 그대로 쓰지 않는다.
///
/// feature별 ARB 분리가 필요할 만큼 커지면 이 패키지를 feature 단위로
/// 나누고 앱에서 delegates를 합치면 된다.
library;

export 'l10n/app_localizations.dart';
export 'src/app_exception_l10n.dart';
export 'src/build_context_l10n.dart';
