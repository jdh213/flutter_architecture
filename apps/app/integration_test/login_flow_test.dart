import 'package:app/main_dev.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// E2E 통합 테스트 — 실제 기기/에뮬레이터에서 앱 전체를 부팅해 검증한다.
///
/// 실행 (기기 필요, 네트워크 필요):
///   cd apps/app
///   flutter test integration_test --flavor dev
///
/// CI에는 포함하지 않는다 (에뮬레이터 부팅 비용 + 외부 네트워크 의존).
/// CI에 넣으려면 별도 워크플로에서 reactivecircus/android-emulator-runner
/// 등으로 에뮬레이터를 띄운 뒤 실행한다.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // 이전 실행이 남긴 토큰/프로필을 정리한다 — 잔존 세션이 있으면 restore()가
  // 자동 로그인해 로그인 화면 단언이 결정적으로 실패한다 (iOS Keychain은
  // 앱 삭제 후에도 남으므로 특히 중요).
  setUp(() => const FlutterSecureStorage().deleteAll());

  testWidgets('로그인하면 게시글 목록이 표시된다', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 세션 복원 완료 → 로그인 화면
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    // FakeAuthApi 지연(800ms) + 목록 API 호출까지 대기
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // 게시글 목록 화면 도착 (목록 or 오프라인 캐시 or 에러 화면 중 목록/캐시 기대)
    expect(find.byType(ListTile), findsWidgets);
  });
}
