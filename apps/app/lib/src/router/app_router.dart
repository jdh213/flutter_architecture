import 'package:app/src/screens/splash_screen.dart';
import 'package:app/src/widgets/logout_button.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_example/feature_example.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// 앱 전역 라우터.
///
/// 인증 분기는 화면이 아니라 redirect가 담당한다:
/// - AuthUnknown       → 스플래시 (세션 복원 중)
/// - Unauthenticated   → 로그인
/// - Authenticated     → 목적지 그대로 (로그인/스플래시에 있었다면 홈으로)
///
/// 화면(feature)은 절대 인증 분기 네비게이션을 하지 않는다.
/// SessionController의 상태만 바꾸면 라우터가 반응한다.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // 인증 상태가 바뀔 때마다 redirect를 재평가시키는 트리거.
  final refreshNotifier = ValueNotifier<int>(0);
  ref
    ..onDispose(refreshNotifier.dispose)
    ..listen(sessionControllerProvider, (_, _) => refreshNotifier.value++);

  return GoRouter(
    initialLocation: PostListScreen.routePath,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final auth = ref.read(sessionControllerProvider);
      final location = state.matchedLocation;
      final atLogin = location == LoginScreen.routePath;
      final atSplash = location == SplashScreen.routePath;

      return switch (auth) {
        AuthUnknown() => atSplash ? null : SplashScreen.routePath,
        Unauthenticated() => atLogin ? null : LoginScreen.routePath,
        Authenticated() =>
          (atLogin || atSplash) ? PostListScreen.routePath : null,
      };
    },
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.routePath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: PostListScreen.routePath,
        // feature 간 연결(로그아웃 버튼)은 composition root가 조립한다.
        builder: (context, state) =>
            const PostListScreen(appBarActions: [LogoutButton()]),
      ),
      GoRoute(
        path: PostDetailScreen.routePath,
        builder: (context, state) => PostDetailScreen(
          postId: int.parse(state.pathParameters['postId']!),
        ),
      ),
    ],
  );
}
