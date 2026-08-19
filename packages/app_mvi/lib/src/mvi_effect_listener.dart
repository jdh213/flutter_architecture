import 'dart:async';

import 'package:app_mvi/src/mvi_contracts.dart';
import 'package:flutter/widgets.dart';

/// ViewModel의 Effect 스트림을 구독해 [onEffect]를 실행하는 위젯.
///
/// 화면 최상단에서 body를 감싼다:
///
/// ```dart
/// @override
/// Widget build(BuildContext context, WidgetRef ref) {
///   final viewModel = ref.read(loginViewModelProvider.notifier);
///   return MviEffectListener<LoginEffect>(
///     effects: viewModel.effects,
///     onEffect: (context, effect) {
///       switch (effect) {
///         case LoginShowError(:final message):
///           ScaffoldMessenger.of(context)
///               .showSnackBar(SnackBar(content: Text(message)));
///       }
///     },
///     child: Scaffold(...),
///   );
/// }
/// ```
class MviEffectListener<E extends MviEffect> extends StatefulWidget {
  const MviEffectListener({
    required this.effects,
    required this.onEffect,
    required this.child,
    super.key,
  });

  final Stream<E> effects;
  final void Function(BuildContext context, E effect) onEffect;
  final Widget child;

  @override
  State<MviEffectListener<E>> createState() => _MviEffectListenerState<E>();
}

class _MviEffectListenerState<E extends MviEffect>
    extends State<MviEffectListener<E>> {
  StreamSubscription<E>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(MviEffectListener<E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ==를 사용한다 — 같은 StreamController에서 나온 스트림은 래퍼 인스턴스가
    // 달라도 동등하므로, rebuild마다 불필요하게 재구독하지 않는다
    // (재구독 사이에 전달 대기 중이던 effect가 유실될 수 있다).
    if (oldWidget.effects != widget.effects) {
      unawaited(_subscription?.cancel());
      _subscribe();
    }
  }

  void _subscribe() {
    _subscription = widget.effects.listen((effect) {
      if (mounted) {
        widget.onEffect(context, effect);
      }
    });
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
