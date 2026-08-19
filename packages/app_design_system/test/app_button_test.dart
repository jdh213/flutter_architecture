import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('라벨을 렌더링하고 탭을 전달한다', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(AppButton(label: '확인', onPressed: () => tapped = true)),
    );

    await tester.tap(find.text('확인'));

    expect(tapped, isTrue);
  });

  testWidgets('isLoading이면 스피너를 표시하고 입력을 차단한다', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(
        AppButton(label: '확인', isLoading: true, onPressed: () => tapped = true),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('확인'), findsNothing);

    await tester.tap(find.byType(AppButton), warnIfMissed: false);
    expect(tapped, isFalse);
  });
}
