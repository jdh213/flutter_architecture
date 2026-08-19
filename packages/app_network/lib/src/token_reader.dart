import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_reader.g.dart';

/// 요청에 첨부할 액세스 토큰을 읽는 함수. null이면 헤더를 붙이지 않는다.
typedef TokenReader = Future<String?> Function();

/// 401 응답을 받았을 때 실행할 처리 (전역 로그아웃 등).
typedef AuthFailureHandler = Future<void> Function();

/// 기본값: 토큰 없음. 앱의 bootstrap에서 feature_auth의 토큰 저장소를
/// 읽는 구현으로 override 한다.
@Riverpod(keepAlive: true)
TokenReader tokenReader(Ref ref) =>
    () async => null;

/// 기본값: 아무것도 하지 않음. 앱의 bootstrap에서 세션 만료 처리
/// (로그아웃 → 로그인 화면 이동)로 override 한다.
@Riverpod(keepAlive: true)
AuthFailureHandler authFailureHandler(Ref ref) => () async {};
