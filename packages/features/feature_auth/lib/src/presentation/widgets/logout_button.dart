import 'package:app_l10n/app_l10n.dart';
import 'package:feature_auth/src/presentation/session/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 인증 feature가 제공하는 로그아웃 버튼.
///
/// 이 위젯은 feature_auth에만 의존한다. 다른 feature의 화면에 넣을 때는
/// composition root(앱)가 파라미터로 주입한다 —
/// 예: 라우터에서 `PostListScreen(appBarActions: [LogoutButton()])`.
class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: context.l10n.logoutTooltip,
      onPressed: () => ref.read(sessionControllerProvider.notifier).logout(),
    );
  }
}
