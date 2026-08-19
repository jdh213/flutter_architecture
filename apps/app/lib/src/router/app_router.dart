import 'package:app_design_system/app_design_system.dart';
import 'package:app_l10n/app_l10n.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_example/feature_example.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// 세션 복원(AuthUnknown) 동안 머무는 대기 경로.
/// 화면이라기보다 라우터의 부속품이라 별도 파일 없이 여기서 소유한다.
const String _splashPath = '/splash';

/// 딥링크 목적지 보존용 쿼리 파라미터.
/// 스플래시/로그인으로 우회하는 동안 원래 목적지를 실어 나른다.
const String _fromParam = 'from';

/// 현재 목적지를 from 파라미터로 실어 [path]로 우회시킨다.
/// 이미 from을 들고 있으면 그대로 승계한다.
String _detourKeepingTarget(String path, GoRouterState state) {
  final target = state.uri.queryParameters[_fromParam] ?? state.uri.toString();
  if (!_isRestorableTarget(target)) return path;
  return Uri(path: path, queryParameters: {_fromParam: target}).toString();
}

/// 인증 완료 후 복귀할 목적지. 없거나 유효하지 않으면 홈(목록).
String _restoreTarget(GoRouterState state) {
  final target = state.uri.queryParameters[_fromParam];
  return (target != null && _isRestorableTarget(target))
      ? target
      : PostListScreen.routePath;
}

/// 내부 경로이면서 우회 경로 자신이 아닌 것만 복귀 대상으로 인정한다
/// (외부 URL·스플래시/로그인 루프 방지).
bool _isRestorableTarget(String target) =>
    target.startsWith('/') &&
    !target.startsWith(_splashPath) &&
    !target.startsWith(LoginScreen.routePath) &&
    target != PostListScreen.routePath;

/// 앱 전역 라우터.
///
/// 인증 분기는 화면이 아니라 redirect가 담당한다:
/// - AuthUnknown       → 스플래시 (세션 복원 중, 목적지는 from으로 보존)
/// - Unauthenticated   → 로그인 (목적지 보존)
/// - Authenticated     → 목적지 그대로 (우회 중이었다면 from으로 복귀)
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
      final atSplash = location == _splashPath;

      return switch (auth) {
        AuthUnknown() =>
          atSplash ? null : _detourKeepingTarget(_splashPath, state),
        Unauthenticated() =>
          atLogin ? null : _detourKeepingTarget(LoginScreen.routePath, state),
        Authenticated() => (atLogin || atSplash) ? _restoreTarget(state) : null,
      };
    },
    // 알 수 없는 경로의 딥링크 등 — 릴리즈의 회색 크래시 화면 대신 안내를 띄운다.
    errorBuilder: (context, state) => Scaffold(
      body: AppErrorView(message: context.l10n.errorNotFound),
    ),
    routes: [
      GoRoute(
        path: _splashPath,
        builder: (context, state) => const Scaffold(body: AppLoadingView()),
      ),
      GoRoute(
        path: LoginScreen.routePath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: PostListScreen.routePath,
        // feature 간 연결(feature_auth의 로그아웃 버튼을 feature_example
        // 화면에 주입)은 composition root가 조립한다.
        builder: (context, state) =>
            const PostListScreen(appBarActions: [LogoutButton()]),
      ),
      GoRoute(
        path: PostDetailScreen.routePath,
        // 비숫자 딥링크(/posts/abc)는 builder의 int.parse 크래시 대신
        // 목록으로 회수한다.
        redirect: (context, state) =>
            int.tryParse(state.pathParameters['postId'] ?? '') == null
            ? PostListScreen.routePath
            : null,
        builder: (context, state) => PostDetailScreen(
          postId: int.parse(state.pathParameters['postId']!),
        ),
      ),
    ],
  );
}
