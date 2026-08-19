import 'package:app/src/router/app_router.dart';
import 'package:app_design_system/app_design_system.dart';
import 'package:app_l10n/app_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Architecture Template',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // 지원 로케일과 델리게이트는 app_l10n이 소유한다.
      // 문자열 추가는 packages/app_l10n/lib/l10n/*.arb 참고.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
