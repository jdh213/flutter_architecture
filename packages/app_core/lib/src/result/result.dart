import 'package:app_core/src/error/app_exception.dart';

/// 성공([Success]) 또는 실패([Failure])를 타입으로 표현하는 반환 규약.
///
/// Repository 계층의 모든 public 메서드는 예외를 던지는 대신 [Result]를
/// 반환한다. 호출부는 [fold] 또는 switch 패턴 매칭으로 두 경우를 모두
/// 처리해야 하며, 이는 컴파일 타임에 강제된다.
///
/// ```dart
/// final result = await repository.fetchPosts();
/// switch (result) {
///   case Success(:final value):
///     state = state.copyWith(posts: value);
///   case Failure(:final exception):
///     emitEffect(PostListEffect.showError(exception.message));
/// }
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;

  const factory Result.failure(AppException exception) = Failure<T>;

  /// 예외를 던질 수 있는 비동기 작업을 [Result]로 감싼다.
  ///
  /// [mapError]로 계층별 예외 변환을 주입한다 (예: DioException → NetworkException).
  /// 변환기가 없거나 변환기가 모르는 예외는 [UnknownException]으로 감싼다.
  static Future<Result<T>> guard<T>(
    Future<T> Function() body, {
    AppException? Function(Object error, StackTrace stackTrace)? mapError,
  }) async {
    try {
      return Result.success(await body());
    } on AppException catch (e) {
      return Result.failure(e);
      // guard의 존재 이유가 "모든 예외를 Result로 수렴"이므로 catch-all이 필요하다.
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      final mapped = mapError?.call(e, st);
      return Result.failure(
        mapped ??
            UnknownException(
              message: '알 수 없는 오류가 발생했습니다.',
              cause: e,
              stackTrace: st,
            ),
      );
    }
  }

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Failure() => null,
  };

  AppException? get exceptionOrNull => switch (this) {
    Success() => null,
    Failure(:final exception) => exception,
  };

  /// 성공/실패를 하나의 값으로 수렴시킨다.
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppException exception) onFailure,
  }) => switch (this) {
    Success(:final value) => onSuccess(value),
    Failure(:final exception) => onFailure(exception),
  };

  /// 성공 값만 변환한다. 실패는 그대로 전파된다.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success(:final value) => Result.success(transform(value)),
    Failure(:final exception) => Result.failure(exception),
  };

  /// [Result]를 반환하는 연산을 연결한다.
  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
    Success(:final value) => transform(value),
    Failure(:final exception) => Result.failure(exception),
  };

  T getOrElse(T Function(AppException exception) orElse) => switch (this) {
    Success(:final value) => value,
    Failure(:final exception) => orElse(exception),
  };
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  String toString() => 'Success($value)';
}

final class Failure<T> extends Result<T> {
  const Failure(this.exception);

  final AppException exception;

  @override
  String toString() => 'Failure($exception)';
}
