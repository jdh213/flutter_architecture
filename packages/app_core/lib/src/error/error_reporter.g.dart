// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_reporter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(errorReporter)
final errorReporterProvider = ErrorReporterProvider._();

final class ErrorReporterProvider
    extends $FunctionalProvider<ErrorReporter, ErrorReporter, ErrorReporter>
    with $Provider<ErrorReporter> {
  ErrorReporterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorReporterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorReporterHash();

  @$internal
  @override
  $ProviderElement<ErrorReporter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ErrorReporter create(Ref ref) {
    return errorReporter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorReporter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorReporter>(value),
    );
  }
}

String _$errorReporterHash() => r'6309f64bc77b618488a81a6c092783aef316d3b7';
