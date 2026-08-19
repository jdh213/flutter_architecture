// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostDetailState {

 bool get isLoading; Post? get post; String? get errorMessage;
/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailStateCopyWith<PostDetailState> get copyWith => _$PostDetailStateCopyWithImpl<PostDetailState>(this as PostDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.post, post) || other.post == post)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,post,errorMessage);

@override
String toString() {
  return 'PostDetailState(isLoading: $isLoading, post: $post, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PostDetailStateCopyWith<$Res>  {
  factory $PostDetailStateCopyWith(PostDetailState value, $Res Function(PostDetailState) _then) = _$PostDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Post? post, String? errorMessage
});


$PostCopyWith<$Res>? get post;

}
/// @nodoc
class _$PostDetailStateCopyWithImpl<$Res>
    implements $PostDetailStateCopyWith<$Res> {
  _$PostDetailStateCopyWithImpl(this._self, this._then);

  final PostDetailState _self;
  final $Res Function(PostDetailState) _then;

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? post = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get post {
    if (_self.post == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.post!, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDetailState].
extension PostDetailStatePatterns on PostDetailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDetailState value)  $default,){
final _that = this;
switch (_that) {
case _PostDetailState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  Post? post,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
return $default(_that.isLoading,_that.post,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  Post? post,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PostDetailState():
return $default(_that.isLoading,_that.post,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  Post? post,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
return $default(_that.isLoading,_that.post,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PostDetailState implements PostDetailState {
  const _PostDetailState({this.isLoading = true, this.post, this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override final  Post? post;
@override final  String? errorMessage;

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDetailStateCopyWith<_PostDetailState> get copyWith => __$PostDetailStateCopyWithImpl<_PostDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.post, post) || other.post == post)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,post,errorMessage);

@override
String toString() {
  return 'PostDetailState(isLoading: $isLoading, post: $post, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PostDetailStateCopyWith<$Res> implements $PostDetailStateCopyWith<$Res> {
  factory _$PostDetailStateCopyWith(_PostDetailState value, $Res Function(_PostDetailState) _then) = __$PostDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Post? post, String? errorMessage
});


@override $PostCopyWith<$Res>? get post;

}
/// @nodoc
class __$PostDetailStateCopyWithImpl<$Res>
    implements _$PostDetailStateCopyWith<$Res> {
  __$PostDetailStateCopyWithImpl(this._self, this._then);

  final _PostDetailState _self;
  final $Res Function(_PostDetailState) _then;

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? post = freezed,Object? errorMessage = freezed,}) {
  return _then(_PostDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get post {
    if (_self.post == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.post!, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

// dart format on
