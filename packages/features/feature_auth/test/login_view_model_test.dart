import 'package:app_core/app_core.dart';
import 'package:feature_auth/src/di.dart';
import 'package:feature_auth/src/domain/entities/auth_status.dart';
import 'package:feature_auth/src/domain/entities/auth_user.dart';
import 'package:feature_auth/src/domain/repositories/auth_repository.dart';
import 'package:feature_auth/src/presentation/login/login_effect.dart';
import 'package:feature_auth/src/presentation/login/login_intent.dart';
import 'package:feature_auth/src/presentation/login/login_view_model.dart';
import 'package:feature_auth/src/presentation/session/session_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const user = AuthUser(id: '1', name: '홍길동', email: 'a@b.c');

  late MockAuthRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWith((ref) => repository),
      ],
      // autoDispose provider가 테스트 중 dispose 되지 않도록 구독을 유지한다.
    )..listen(loginViewModelProvider, (_, _) {});
    addTearDown(container.dispose);
  });

  LoginViewModel viewModel() => container.read(loginViewModelProvider.notifier);

  test('입력 intent가 state를 갱신하고 canSubmit을 계산한다', () {
    expect(container.read(loginViewModelProvider).canSubmit, isFalse);

    viewModel()
      ..onIntent(const LoginEmailChanged('a@b.c'))
      ..onIntent(const LoginPasswordChanged('pw'));

    final state = container.read(loginViewModelProvider);
    expect(state.email, 'a@b.c');
    expect(state.password, 'pw');
    expect(state.canSubmit, isTrue);
  });

  test('로그인 성공 시 세션이 Authenticated로 전이된다', () async {
    when(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Result.success(user));

    viewModel()
      ..onIntent(const LoginEmailChanged('a@b.c'))
      ..onIntent(const LoginPasswordChanged('pw'))
      ..onIntent(const LoginSubmitted());
    await pumpEventQueue();

    final session = container.read(sessionControllerProvider);
    expect(session, isA<Authenticated>());
    expect((session as Authenticated).user, user);
  });

  test('로그인 실패 시 에러 Effect를 방출하고 isSubmitting을 해제한다', () async {
    when(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Result.failure(
        NetworkException(message: '로그인 실패', type: NetworkErrorType.server),
      ),
    );

    final effects = <LoginEffect>[];
    final subscription = viewModel().effects.listen(effects.add);
    addTearDown(subscription.cancel);

    viewModel()
      ..onIntent(const LoginEmailChanged('a@b.c'))
      ..onIntent(const LoginPasswordChanged('pw'))
      ..onIntent(const LoginSubmitted());
    await pumpEventQueue();

    expect(effects, [
      isA<LoginShowError>().having(
        (e) => e.exception.message,
        'exception.message',
        '로그인 실패',
      ),
    ]);
    expect(container.read(loginViewModelProvider).isSubmitting, isFalse);
    expect(
      container.read(sessionControllerProvider),
      isA<AuthUnknown>(),
      reason: '실패 시 세션 상태는 변하지 않는다',
    );
  });

  test('canSubmit이 false면 제출하지 않는다', () async {
    viewModel().onIntent(const LoginSubmitted());
    await pumpEventQueue();

    verifyNever(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    );
  });
}
