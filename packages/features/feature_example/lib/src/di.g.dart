// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// feature 내부 배선(조립) 파일.
///
/// provider의 위치 규칙: "그 타입을 만들 줄 아는 가장 안쪽 파일"에 둔다.
/// - Repository provider → 구현 파일 옆 (data 계층)
/// - UseCase provider → UseCase 클래스는 domain(순수)에 있지만 배선에는
///   data의 repository provider가 필요하다. domain이 data를 import 하면
///   의존성 규칙 위반이므로, 배선만 이 파일이 담당한다.

@ProviderFor(getPostDetailUseCase)
final getPostDetailUseCaseProvider = GetPostDetailUseCaseProvider._();

/// feature 내부 배선(조립) 파일.
///
/// provider의 위치 규칙: "그 타입을 만들 줄 아는 가장 안쪽 파일"에 둔다.
/// - Repository provider → 구현 파일 옆 (data 계층)
/// - UseCase provider → UseCase 클래스는 domain(순수)에 있지만 배선에는
///   data의 repository provider가 필요하다. domain이 data를 import 하면
///   의존성 규칙 위반이므로, 배선만 이 파일이 담당한다.

final class GetPostDetailUseCaseProvider
    extends
        $FunctionalProvider<
          GetPostDetailUseCase,
          GetPostDetailUseCase,
          GetPostDetailUseCase
        >
    with $Provider<GetPostDetailUseCase> {
  /// feature 내부 배선(조립) 파일.
  ///
  /// provider의 위치 규칙: "그 타입을 만들 줄 아는 가장 안쪽 파일"에 둔다.
  /// - Repository provider → 구현 파일 옆 (data 계층)
  /// - UseCase provider → UseCase 클래스는 domain(순수)에 있지만 배선에는
  ///   data의 repository provider가 필요하다. domain이 data를 import 하면
  ///   의존성 규칙 위반이므로, 배선만 이 파일이 담당한다.
  GetPostDetailUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPostDetailUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPostDetailUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPostDetailUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPostDetailUseCase create(Ref ref) {
    return getPostDetailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPostDetailUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPostDetailUseCase>(value),
    );
  }
}

String _$getPostDetailUseCaseHash() =>
    r'a3fe633a25f67a9cb1853471a9f7b4a614900183';
