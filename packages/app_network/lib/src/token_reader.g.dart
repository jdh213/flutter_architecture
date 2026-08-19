// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 기본값: 토큰 없음. 앱의 bootstrap에서 feature_auth의 토큰 저장소를
/// 읽는 구현으로 override 한다.

@ProviderFor(tokenReader)
final tokenReaderProvider = TokenReaderProvider._();

/// 기본값: 토큰 없음. 앱의 bootstrap에서 feature_auth의 토큰 저장소를
/// 읽는 구현으로 override 한다.

final class TokenReaderProvider
    extends $FunctionalProvider<TokenReader, TokenReader, TokenReader>
    with $Provider<TokenReader> {
  /// 기본값: 토큰 없음. 앱의 bootstrap에서 feature_auth의 토큰 저장소를
  /// 읽는 구현으로 override 한다.
  TokenReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenReaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenReaderHash();

  @$internal
  @override
  $ProviderElement<TokenReader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenReader create(Ref ref) {
    return tokenReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenReader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenReader>(value),
    );
  }
}

String _$tokenReaderHash() => r'9a794419ea6e57a08fec67ad039d01a2c0a29b4c';

/// 기본값: 아무것도 하지 않음. 앱의 bootstrap에서 세션 만료 처리
/// (로그아웃 → 로그인 화면 이동)로 override 한다.

@ProviderFor(authFailureHandler)
final authFailureHandlerProvider = AuthFailureHandlerProvider._();

/// 기본값: 아무것도 하지 않음. 앱의 bootstrap에서 세션 만료 처리
/// (로그아웃 → 로그인 화면 이동)로 override 한다.

final class AuthFailureHandlerProvider
    extends
        $FunctionalProvider<
          AuthFailureHandler,
          AuthFailureHandler,
          AuthFailureHandler
        >
    with $Provider<AuthFailureHandler> {
  /// 기본값: 아무것도 하지 않음. 앱의 bootstrap에서 세션 만료 처리
  /// (로그아웃 → 로그인 화면 이동)로 override 한다.
  AuthFailureHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authFailureHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authFailureHandlerHash();

  @$internal
  @override
  $ProviderElement<AuthFailureHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthFailureHandler create(Ref ref) {
    return authFailureHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthFailureHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthFailureHandler>(value),
    );
  }
}

String _$authFailureHandlerHash() =>
    r'ecc49ccce0cf5e33c0ff10cdb903bb5d4567a5f2';
