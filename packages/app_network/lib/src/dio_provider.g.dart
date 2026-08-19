// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 인터셉터가 구성된 전역 [Dio] 인스턴스.
///
/// feature의 remote data source는 이 provider를 주입받아 사용한다.
/// baseUrl이 다른 별도 API 서버가 필요하면 이 파일에 provider를 추가한다.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// 인터셉터가 구성된 전역 [Dio] 인스턴스.
///
/// feature의 remote data source는 이 provider를 주입받아 사용한다.
/// baseUrl이 다른 별도 API 서버가 필요하면 이 파일에 provider를 추가한다.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// 인터셉터가 구성된 전역 [Dio] 인스턴스.
  ///
  /// feature의 remote data source는 이 provider를 주입받아 사용한다.
  /// baseUrl이 다른 별도 API 서버가 필요하면 이 파일에 provider를 추가한다.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'bcbcd84c3b0f052bcabb9baa7c30f48e9c949447';
