// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 환경 설정 provider.
///
/// 기본 구현은 의도적으로 throw 한다 — 앱이 bootstrap에서 반드시
/// override 해야 함을 컴파일이 아닌 첫 접근 시점에 명확한 메시지로 알린다.
/// 이것이 이 템플릿의 표준 DI 패턴이다. (Hilt의 @Provides 모듈을
/// 앱 모듈에서 갈아끼우는 것과 같은 역할)

@ProviderFor(envConfig)
final envConfigProvider = EnvConfigProvider._();

/// 환경 설정 provider.
///
/// 기본 구현은 의도적으로 throw 한다 — 앱이 bootstrap에서 반드시
/// override 해야 함을 컴파일이 아닌 첫 접근 시점에 명확한 메시지로 알린다.
/// 이것이 이 템플릿의 표준 DI 패턴이다. (Hilt의 @Provides 모듈을
/// 앱 모듈에서 갈아끼우는 것과 같은 역할)

final class EnvConfigProvider
    extends $FunctionalProvider<EnvConfig, EnvConfig, EnvConfig>
    with $Provider<EnvConfig> {
  /// 환경 설정 provider.
  ///
  /// 기본 구현은 의도적으로 throw 한다 — 앱이 bootstrap에서 반드시
  /// override 해야 함을 컴파일이 아닌 첫 접근 시점에 명확한 메시지로 알린다.
  /// 이것이 이 템플릿의 표준 DI 패턴이다. (Hilt의 @Provides 모듈을
  /// 앱 모듈에서 갈아끼우는 것과 같은 역할)
  EnvConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'envConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$envConfigHash();

  @$internal
  @override
  $ProviderElement<EnvConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EnvConfig create(Ref ref) {
    return envConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnvConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnvConfig>(value),
    );
  }
}

String _$envConfigHash() => r'f737907e84ff4cf6e85abe4b7900351ae85229be';
