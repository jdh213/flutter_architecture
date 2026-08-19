/// dio 기반 네트워크 계층.
///
/// - `dioProvider` : 인터셉터가 구성된 전역 Dio 인스턴스
/// - safeApiCall : API 호출을 Result로 감싸고 DioException을 NetworkException으로 변환
/// - tokenReaderProvider / authFailureHandlerProvider :
///   인증 의존성 역전 지점. 이 패키지는 feature_auth를 모르지만,
///   앱(composition root)이 두 provider를 override 하여 연결한다.
///   (의존성 방향: feature_auth → app_network 이므로 역방향 참조가 불가능하다.
///    이것이 이 템플릿의 표준 의존성 역전 패턴이다.)
library;

export 'src/dio_provider.dart';
export 'src/exception_mapper.dart';
export 'src/interceptors/auth_token_interceptor.dart';
export 'src/safe_api_call.dart';
export 'src/token_reader.dart';
