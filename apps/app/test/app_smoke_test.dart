import 'package:app/src/app.dart';
import 'package:app/src/screens/splash_screen.dart';
import 'package:app_core/app_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('앱이 부팅되고 세션 복원(AuthUnknown) 동안 스플래시를 표시한다', (tester) async {
    final container = ProviderContainer(
      overrides: [
        envConfigProvider.overrideWith(
          (ref) => const EnvConfig(
            flavor: AppFlavor.dev,
            apiBaseUrl: 'https://example.com',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const App()),
    );
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
