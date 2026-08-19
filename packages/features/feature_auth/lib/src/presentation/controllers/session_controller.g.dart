// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 전역 인증 상태 컨트롤러.
///
/// 화면 단위 MVI ViewModel이 아니라 앱 수준의 세션 상태다.
/// 라우터의 redirect가 이 상태를 구독해 로그인/홈 분기를 결정하므로
/// 화면에서 직접 네비게이션하지 않는다 — 상태만 바꾸면 라우터가 반응한다.

@ProviderFor(SessionController)
final sessionControllerProvider = SessionControllerProvider._();

/// 전역 인증 상태 컨트롤러.
///
/// 화면 단위 MVI ViewModel이 아니라 앱 수준의 세션 상태다.
/// 라우터의 redirect가 이 상태를 구독해 로그인/홈 분기를 결정하므로
/// 화면에서 직접 네비게이션하지 않는다 — 상태만 바꾸면 라우터가 반응한다.
final class SessionControllerProvider
    extends $NotifierProvider<SessionController, AuthStatus> {
  /// 전역 인증 상태 컨트롤러.
  ///
  /// 화면 단위 MVI ViewModel이 아니라 앱 수준의 세션 상태다.
  /// 라우터의 redirect가 이 상태를 구독해 로그인/홈 분기를 결정하므로
  /// 화면에서 직접 네비게이션하지 않는다 — 상태만 바꾸면 라우터가 반응한다.
  SessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionControllerHash();

  @$internal
  @override
  SessionController create() => SessionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStatus>(value),
    );
  }
}

String _$sessionControllerHash() => r'46c375094915791aaf1ae892e6cf9a959452c479';

/// 전역 인증 상태 컨트롤러.
///
/// 화면 단위 MVI ViewModel이 아니라 앱 수준의 세션 상태다.
/// 라우터의 redirect가 이 상태를 구독해 로그인/홈 분기를 결정하므로
/// 화면에서 직접 네비게이션하지 않는다 — 상태만 바꾸면 라우터가 반응한다.

abstract class _$SessionController extends $Notifier<AuthStatus> {
  AuthStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthStatus, AuthStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthStatus, AuthStatus>,
              AuthStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
