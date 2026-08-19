import 'package:app/src/bootstrap.dart';
import 'package:app_core/app_core.dart';

/// prod flavor 진입점.
///
/// 실행: flutter run --flavor prod -t lib/main_prod.dart
void main() => bootstrap(
  const EnvConfig(
    flavor: AppFlavor.prod,
    // 프로젝트 시작 시 운영 서버 주소로 교체한다.
    apiBaseUrl: 'https://jsonplaceholder.typicode.com',
  ),
);
