import 'package:feature_auth/feature_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// feature_example의 화면에 주입되는 로그아웃 버튼.
///
/// feature_example은 feature_auth를 모르므로, 두 feature를 잇는
/// 이 위젯은 composition root(앱)에 위치한다.
class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: '로그아웃',
      onPressed: () => ref.read(sessionControllerProvider.notifier).logout(),
    );
  }
}
