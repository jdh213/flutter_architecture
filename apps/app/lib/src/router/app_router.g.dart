// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전역 라우터.
///
/// 인증 분기는 화면이 아니라 redirect가 담당한다:
/// - AuthUnknown       → 스플래시 (세션 복원 중, 목적지는 from으로 보존)
/// - Unauthenticated   → 로그인 (목적지 보존)
/// - Authenticated     → 목적지 그대로 (우회 중이었다면 from으로 복귀)
///
/// 화면(feature)은 절대 인증 분기 네비게이션을 하지 않는다.
/// SessionController의 상태만 바꾸면 라우터가 반응한다.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// 앱 전역 라우터.
///
/// 인증 분기는 화면이 아니라 redirect가 담당한다:
/// - AuthUnknown       → 스플래시 (세션 복원 중, 목적지는 from으로 보존)
/// - Unauthenticated   → 로그인 (목적지 보존)
/// - Authenticated     → 목적지 그대로 (우회 중이었다면 from으로 복귀)
///
/// 화면(feature)은 절대 인증 분기 네비게이션을 하지 않는다.
/// SessionController의 상태만 바꾸면 라우터가 반응한다.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// 앱 전역 라우터.
  ///
  /// 인증 분기는 화면이 아니라 redirect가 담당한다:
  /// - AuthUnknown       → 스플래시 (세션 복원 중, 목적지는 from으로 보존)
  /// - Unauthenticated   → 로그인 (목적지 보존)
  /// - Authenticated     → 목적지 그대로 (우회 중이었다면 from으로 복귀)
  ///
  /// 화면(feature)은 절대 인증 분기 네비게이션을 하지 않는다.
  /// SessionController의 상태만 바꾸면 라우터가 반응한다.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'b718db604a428022b4f6998b93bc40128551bbbc';
