import 'package:app_core/app_core.dart';
import 'package:test/test.dart';

void main() {
  group('Result.guard', () {
    test('성공 값을 Success로 감싼다', () async {
      final result = await Result.guard(() async => 42);

      expect(result, isA<Success<int>>());
      expect(result.valueOrNull, 42);
    });

    test('AppException은 변환 없이 그대로 Failure로 전달된다', () async {
      const exception = ValidationException(message: '검증 실패');

      final result = await Result.guard<int>(() async => throw exception);

      expect(result.exceptionOrNull, same(exception));
    });

    test('mapError가 변환한 예외를 사용한다', () async {
      final result = await Result.guard<int>(
        () async => throw const FormatException('bad'),
        mapError: (e, st) =>
            CacheException(message: '캐시 오류', cause: e, stackTrace: st),
      );

      expect(result.exceptionOrNull, isA<CacheException>());
    });

    test('mapError가 모르는 예외는 UnknownException으로 감싼다', () async {
      final result = await Result.guard<int>(
        () async => throw StateError('boom'),
        mapError: (e, st) => null,
      );

      expect(result.exceptionOrNull, isA<UnknownException>());
      expect(result.exceptionOrNull!.cause, isA<StateError>());
    });
  });

  group('변환 연산', () {
    test('fold는 성공/실패를 하나의 값으로 수렴시킨다', () {
      const success = Result.success(2);
      const failure = Result<int>.failure(UnknownException(message: '실패'));

      expect(
        success.fold(onSuccess: (v) => v * 10, onFailure: (_) => -1),
        20,
      );
      expect(
        failure.fold(onSuccess: (v) => v * 10, onFailure: (_) => -1),
        -1,
      );
    });

    test('map은 성공 값만 변환하고 실패는 그대로 전파한다', () {
      const exception = UnknownException(message: '실패');

      expect(const Result.success(2).map((v) => '$v').valueOrNull, '2');
      expect(
        const Result<int>.failure(exception).map((v) => '$v').exceptionOrNull,
        same(exception),
      );
    });

    test('flatMap은 Result 반환 연산을 연결한다', () {
      const exception = ValidationException(message: '음수 금지');
      Result<int> validate(int v) =>
          v >= 0 ? Result.success(v) : const Result.failure(exception);

      expect(const Result.success(1).flatMap(validate).isSuccess, isTrue);
      expect(
        const Result.success(-1).flatMap(validate).exceptionOrNull,
        same(exception),
      );
    });

    test('getOrElse는 실패 시 대체 값을 반환한다', () {
      const failure = Result<int>.failure(UnknownException(message: '실패'));

      expect(failure.getOrElse((_) => 0), 0);
    });
  });
}
