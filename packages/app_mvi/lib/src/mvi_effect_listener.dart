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
    if (!identical(oldWidget.effects, widget.effects)) {
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
