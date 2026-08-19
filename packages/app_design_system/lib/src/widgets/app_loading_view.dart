import 'package:flutter/material.dart';

/// 화면 전체 로딩 표시.
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
