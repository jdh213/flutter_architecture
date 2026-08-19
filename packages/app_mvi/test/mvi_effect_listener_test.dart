import 'package:app_mvi/app_mvi.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

sealed class _TestEffect implements MviEffect {
  const _TestEffect();
}

final class _Ping extends _TestEffect {
  const _Ping(this.value);

  final int value;
}

class _TestEmitter with MviEffectEmitter<_TestEffect> {}

void main() {
  testWidgets('방출된 Effect가 onEffect 콜백으로 전달된다', (tester) async {
    final emitter = _TestEmitter();
    final received = <_TestEffect>[];

    await tester.pumpWidget(
      MviEffectListener<_TestEffect>(
        effects: emitter.effects,
        onEffect: (context, effect) => received.add(effect),
        child: const SizedBox(),
      ),
    );

    emitter
      ..emitEffect(const _Ping(1))
      ..emitEffect(const _Ping(2));
    await tester.pump();

    expect(received, hasLength(2));
    expect((received.first as _Ping).value, 1);

    emitter.disposeEffects();
  });

  testWidgets('위젯이 dispose 되면 더 이상 Effect를 받지 않는다', (tester) async {
    final emitter = _TestEmitter();
    final received = <_TestEffect>[];

    await tester.pumpWidget(
      MviEffectListener<_TestEffect>(
        effects: emitter.effects,
        onEffect: (context, effect) => received.add(effect),
        child: const SizedBox(),
      ),
    );
    await tester.pumpWidget(const SizedBox());

    emitter.emitEffect(const _Ping(1));
    await tester.pump();

    expect(received, isEmpty);

    emitter.disposeEffects();
  });
}
