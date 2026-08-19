// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_cache_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jsonCacheStore)
final jsonCacheStoreProvider = JsonCacheStoreProvider._();

final class JsonCacheStoreProvider
    extends $FunctionalProvider<JsonCacheStore, JsonCacheStore, JsonCacheStore>
    with $Provider<JsonCacheStore> {
  JsonCacheStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jsonCacheStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jsonCacheStoreHash();

  @$internal
  @override
  $ProviderElement<JsonCacheStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JsonCacheStore create(Ref ref) {
    return jsonCacheStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JsonCacheStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JsonCacheStore>(value),
    );
  }
}

String _$jsonCacheStoreHash() => r'7dd9887d49295b262619024c65277280f76a74f6';
