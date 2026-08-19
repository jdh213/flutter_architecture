import 'dart:async';

import 'package:app_mvi/src/mvi_contracts.dart';

/// ViewModel(Riverpod Notifier)에 Effect 방출 능력을 부여하는 mixin.
///
/// 사용법 — Notifier의 build()에서 반드시 `ref.onDispose(disposeEffects)`를
/// 등록한다:
///
/// ```dart
/// @riverpod
/// class LoginViewModel extends _$LoginViewModel
///     with MviEffectEmitter<LoginEffect> {
///   @override
///   LoginState build() {
///     ref.onDispose(disposeEffects);
///     return const LoginState();
///   }
///
///   void onIntent(LoginIntent intent) {
///     switch (intent) {
///       case LoginSubmitted():
///         _submit();
///       // ...
///     }
///   }
/// }
/// ```
///
/// 전달 보장: 구독자가 없는 순간에 방출된 Effect는 버퍼에 쌓였다가
/// 다음 구독자가 붙는 즉시 순서대로 전달된다. 따라서 화면 빌드보다
/// 먼저 방출된 Effect도 유실되지 않는다. (구독자가 끝내 나타나지 않으면
/// disposeEffects 시점에 버퍼는 폐기된다)
mixin MviEffectEmitter<E extends MviEffect> {
  late final StreamController<E> _effectController =
      StreamController<E>.broadcast(onListen: _flushPending);

  // StreamController.stream getter는 접근마다 새 래퍼를 만들므로 캐싱한다 —
  // View(MviEffectListener)가 rebuild마다 다른 스트림으로 오인해
  // 구독을 재생성하는 것을 막는다.
  late final Stream<E> _effects = _effectController.stream;

  final List<E> _pendingEffects = [];

  /// View가 구독하는 Effect 스트림. `MviEffectListener` 위젯과 함께 사용한다.
  /// 항상 동일한 인스턴스를 반환한다.
  Stream<E> get effects => _effects;

  /// Effect를 방출한다. 구독자가 없으면 버퍼링 후 첫 구독자에게 전달한다.
  void emitEffect(E effect) {
    if (_effectController.isClosed) return;
    if (_effectController.hasListener) {
      _effectController.add(effect);
    } else {
      _pendingEffects.add(effect);
    }
  }

  void _flushPending() {
    if (_pendingEffects.isEmpty) return;
    final pending = List.of(_pendingEffects);
    _pendingEffects.clear();
    pending.forEach(_effectController.add);
  }

  /// Notifier의 build()에서 `ref.onDispose(disposeEffects)`로 등록한다.
  void disposeEffects() {
    _pendingEffects.clear();
    unawaited(_effectController.close());
  }
}
