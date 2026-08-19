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
mixin MviEffectEmitter<E extends MviEffect> {
  final StreamController<E> _effectController = StreamController<E>.broadcast();

  /// View가 구독하는 Effect 스트림. `MviEffectListener` 위젯과 함께 사용한다.
  Stream<E> get effects => _effectController.stream;

  /// Effect를 방출한다. 구독자가 없으면 조용히 버려진다 (broadcast).
  void emitEffect(E effect) {
    if (!_effectController.isClosed) {
      _effectController.add(effect);
    }
  }

  /// Notifier의 build()에서 `ref.onDispose(disposeEffects)`로 등록한다.
  void disposeEffects() {
    unawaited(_effectController.close());
  }
}
