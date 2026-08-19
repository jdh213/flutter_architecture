import 'package:app_core/app_core.dart';
import 'package:app_network/app_network.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  DioException dioError({
    required DioExceptionType type,
    int? statusCode,
  }) {
    final options = RequestOptions(path: '/test');
    return DioException(
      requestOptions: options,
      type: type,
      response: statusCode == null
          ? null
          : Response<void>(requestOptions: options, statusCode: statusCode),
    );
  }

  group('mapDioException', () {
    test('타임아웃 계열은 timeout으로 매핑된다', () {
      for (final type in [
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
      ]) {
        expect(
          mapDioException(dioError(type: type)).type,
          NetworkErrorType.timeout,
        );
      }
    });

    test('connectionError는 noConnection으로 매핑된다', () {
      expect(
        mapDioException(dioError(type: DioExceptionType.connectionError)).type,
        NetworkErrorType.noConnection,
      );
    });

    test('상태 코드별로 분류된다', () {
      const cases = {
        401: NetworkErrorType.unauthorized,
        403: NetworkErrorType.forbidden,
        404: NetworkErrorType.notFound,
        500: NetworkErrorType.server,
        503: NetworkErrorType.server,
        418: NetworkErrorType.unknown,
      };

      for (final MapEntry(key: statusCode, value: expected) in cases.entries) {
        final mapped = mapDioException(
          dioError(type: DioExceptionType.badResponse, statusCode: statusCode),
        );
        expect(mapped.type, expected, reason: 'status $statusCode');
        expect(mapped.statusCode, statusCode);
      }
    });

    test('원본 예외를 cause에 보존한다', () {
      final original = dioError(type: DioExceptionType.cancel);

      expect(mapDioException(original).cause, same(original));
    });
  });

  group('safeApiCall', () {
    test('DioException을 NetworkException Failure로 변환한다', () async {
      final result = await safeApiCall<int>(
        () async => throw dioError(
          type: DioExceptionType.badResponse,
          statusCode: 500,
        ),
      );

      expect(result.exceptionOrNull, isA<NetworkException>());
    });

    test('성공 값은 Success로 감싼다', () async {
      final result = await safeApiCall(() async => 'ok');

      expect(result.valueOrNull, 'ok');
    });
  });
}
