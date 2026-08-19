// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostListState {

 bool get isLoading; bool get isRefreshing; List<Post> get posts; bool get isFromCache; String? get errorMessage;
/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostListStateCopyWith<PostListState> get copyWith => _$PostListStateCopyWithImpl<PostListState>(this as PostListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.isFromCache, isFromCache) || other.isFromCache == isFromCache)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,const DeepCollectionEquality().hash(posts),isFromCache,errorMessage);

@override
String toString() {
  return 'PostListState(isLoading: $isLoading, isRefreshing: $isRefreshing, posts: $posts, isFromCache: $isFromCache, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PostListStateCopyWith<$Res>  {
  factory $PostListStateCopyWith(PostListState value, $Res Function(PostListState) _then) = _$PostListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, List<Post> posts, bool isFromCache, String? errorMessage
});




}
/// @nodoc
class _$PostListStateCopyWithImpl<$Res>
    implements $PostListStateCopyWith<$Res> {
  _$PostListStateCopyWithImpl(this._self, this._then);

  final PostListState _self;
  final $Res Function(PostListState) _then;

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? posts = null,Object? isFromCache = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,isFromCache: null == isFromCache ? _self.isFromCache : isFromCache // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostListState].
extension PostListStatePatterns on PostListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostListState value)  $default,){
final _that = this;
switch (_that) {
case _PostListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostListState value)?  $default,){
final _that = this;
switch (_that) {
case _PostListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  List<Post> posts,  bool isFromCache,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostListState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.posts,_that.isFromCache,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  List<Post> posts,  bool isFromCache,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PostListState():
return $default(_that.isLoading,_that.isRefreshing,_that.posts,_that.isFromCache,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isRefreshing,  List<Post> posts,  bool isFromCache,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PostListState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.posts,_that.isFromCache,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PostListState extends PostListState {
  const _PostListState({this.isLoading = true, this.isRefreshing = false, final  List<Post> posts = const [], this.isFromCache = false, this.errorMessage}): _posts = posts,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  bool isFromCache;
@override final  String? errorMessage;

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostListStateCopyWith<_PostListState> get copyWith => __$PostListStateCopyWithImpl<_PostListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.isFromCache, isFromCache) || other.isFromCache == isFromCache)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,const DeepCollectionEquality().hash(_posts),isFromCache,errorMessage);

@override
String toString() {
  return 'PostListState(isLoading: $isLoading, isRefreshing: $isRefreshing, posts: $posts, isFromCache: $isFromCache, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PostListStateCopyWith<$Res> implements $PostListStateCopyWith<$Res> {
  factory _$PostListStateCopyWith(_PostListState value, $Res Function(_PostListState) _then) = __$PostListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, List<Post> posts, bool isFromCache, String? errorMessage
});




}
/// @nodoc
class __$PostListStateCopyWithImpl<$Res>
    implements _$PostListStateCopyWith<$Res> {
  __$PostListStateCopyWithImpl(this._self, this._then);

  final _PostListState _self;
  final $Res Function(_PostListState) _then;

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? posts = null,Object? isFromCache = null,Object? errorMessage = freezed,}) {
  return _then(_PostListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,isFromCache: null == isFromCache ? _self.isFromCache : isFromCache // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
