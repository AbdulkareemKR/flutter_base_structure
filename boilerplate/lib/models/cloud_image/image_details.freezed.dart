// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageDetails _$ImageDetailsFromJson(Map<String, dynamic> json) {
  return _ImageDetails.fromJson(json);
}

/// @nodoc
mixin _$ImageDetails {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageDetailsCopyWith<ImageDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDetailsCopyWith<$Res> {
  factory $ImageDetailsCopyWith(
          ImageDetails value, $Res Function(ImageDetails) then) =
      _$ImageDetailsCopyWithImpl<$Res, ImageDetails>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$ImageDetailsCopyWithImpl<$Res, $Val extends ImageDetails>
    implements $ImageDetailsCopyWith<$Res> {
  _$ImageDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageDetailsCopyWith<$Res>
    implements $ImageDetailsCopyWith<$Res> {
  factory _$$_ImageDetailsCopyWith(
          _$_ImageDetails value, $Res Function(_$_ImageDetails) then) =
      __$$_ImageDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$_ImageDetailsCopyWithImpl<$Res>
    extends _$ImageDetailsCopyWithImpl<$Res, _$_ImageDetails>
    implements _$$_ImageDetailsCopyWith<$Res> {
  __$$_ImageDetailsCopyWithImpl(
      _$_ImageDetails _value, $Res Function(_$_ImageDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$_ImageDetails(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImageDetails implements _ImageDetails {
  _$_ImageDetails({required this.url});

  factory _$_ImageDetails.fromJson(Map<String, dynamic> json) =>
      _$$_ImageDetailsFromJson(json);

  @override
  final String url;

  @override
  String toString() {
    return 'ImageDetails(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageDetails &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageDetailsCopyWith<_$_ImageDetails> get copyWith =>
      __$$_ImageDetailsCopyWithImpl<_$_ImageDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageDetailsToJson(
      this,
    );
  }
}

abstract class _ImageDetails implements ImageDetails {
  factory _ImageDetails({required final String url}) = _$_ImageDetails;

  factory _ImageDetails.fromJson(Map<String, dynamic> json) =
      _$_ImageDetails.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_ImageDetailsCopyWith<_$_ImageDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
