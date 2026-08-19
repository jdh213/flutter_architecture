import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';

/// 세션 복원(AuthUnknown) 동안 표시되는 스플래시.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routePath = '/splash';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AppLoadingView());
  }
}
