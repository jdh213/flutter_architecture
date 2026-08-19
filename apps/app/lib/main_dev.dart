import 'package:app/src/bootstrap.dart';
import 'package:app_core/app_core.dart';

/// dev flavor 진입점.
///
/// 실행: flutter run --flavor dev -t lib/main_dev.dart
///
/// API 키 등 비밀값은 여기 하드코딩하지 말고 dart-define으로 주입한다:
/// flutter run --flavor dev -t lib/main_dev.dart \
///   --dart-define-from-file=env/dev.local.json
void main() => bootstrap(
  const EnvConfig(
    flavor: AppFlavor.dev,
    apiBaseUrl: 'https://jsonplaceholder.typicode.com',
    enableNetworkLog: true,
  ),
);
