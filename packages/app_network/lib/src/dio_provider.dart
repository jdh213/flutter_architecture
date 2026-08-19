import 'package:app_core/app_core.dart';
import 'package:app_network/src/interceptors/auth_token_interceptor.dart';
import 'package:app_network/src/token_reader.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// 인터셉터가 구성된 전역 [Dio] 인스턴스.
///
/// feature의 remote data source는 이 provider를 주입받아 사용한다.
/// baseUrl이 다른 별도 API 서버가 필요하면 이 파일에 provider를 추가한다.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final env = ref.watch(envConfigProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    AuthTokenInterceptor(
      readToken: ref.watch(tokenReaderProvider),
      onAuthFailure: ref.watch(authFailureHandlerProvider),
    ),
  );

  // 로그 정책 (보안):
  // - 헤더는 어떤 flavor에서도 로그하지 않는다 (Authorization Bearer 토큰 유출 방지).
  // - 바디는 dev flavor에서만 로그한다 (stg는 실서버 자격증명이 오갈 수 있다).
  // - prod에서 enableNetworkLog=true는 EnvConfig의 assert가 컴파일 시점에 차단한다.
  if (env.enableNetworkLog && !env.isProd) {
    final verbose = env.flavor == AppFlavor.dev;
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        requestBody: verbose,
        responseBody: verbose,
      ),
    );
  }

  return dio;
}
