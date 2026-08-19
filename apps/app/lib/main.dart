import 'package:app/main_dev.dart' as dev;

/// 기본 진입점 — dev flavor로 위임한다.
///
/// `flutter run`을 인자 없이 실행해도 동작하도록 유지한다.
/// (flavor를 명시하려면 README의 실행 명령 참고)
void main() => dev.main();
