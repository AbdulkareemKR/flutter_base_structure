// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cloud_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CloudImage _$CloudImageFromJson(Map<String, dynamic> json) {
  return _CloudImage.fromJson(json);
}

/// @nodoc
mixin _$CloudImage {
  String get hash => throw _privateConstructorUsedError;
  ImageDetails get full => throw _privateConstructorUsedError;
  ImageDetails get large => throw _privateConstructorUsedError;
  ImageDetails get medium => throw _privateConstructorUsedError;
  ImageDetails get small => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CloudImageCopyWith<CloudImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudImageCopyWith<$Res> {
  factory $CloudImageCopyWith(
          CloudImage value, $Res Function(CloudImage) then) =
      _$CloudImageCopyWithImpl<$Res, CloudImage>;
  @useResult
  $Res call(
      {String hash,
      ImageDetails full,
      ImageDetails large,
      ImageDetails medium,
      ImageDetails small});

  $ImageDetailsCopyWith<$Res> get full;
  $ImageDetailsCopyWith<$Res> get large;
  $ImageDetailsCopyWith<$Res> get medium;
  $ImageDetailsCopyWith<$Res> get small;
}

/// @nodoc
class _$CloudImageCopyWithImpl<$Res, $Val extends CloudImage>
    implements $CloudImageCopyWith<$Res> {
  _$CloudImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? full = null,
    Object? large = null,
    Object? medium = null,
    Object? small = null,
  }) {
    return _then(_value.copyWith(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      full: null == full
          ? _value.full
          : full // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageDetailsCopyWith<$Res> get full {
    return $ImageDetailsCopyWith<$Res>(_value.full, (value) {
      return _then(_value.copyWith(full: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageDetailsCopyWith<$Res> get large {
    return $ImageDetailsCopyWith<$Res>(_value.large, (value) {
      return _then(_value.copyWith(large: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageDetailsCopyWith<$Res> get medium {
    return $ImageDetailsCopyWith<$Res>(_value.medium, (value) {
      return _then(_value.copyWith(medium: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageDetailsCopyWith<$Res> get small {
    return $ImageDetailsCopyWith<$Res>(_value.small, (value) {
      return _then(_value.copyWith(small: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CloudImageCopyWith<$Res>
    implements $CloudImageCopyWith<$Res> {
  factory _$$_CloudImageCopyWith(
          _$_CloudImage value, $Res Function(_$_CloudImage) then) =
      __$$_CloudImageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hash,
      ImageDetails full,
      ImageDetails large,
      ImageDetails medium,
      ImageDetails small});

  @override
  $ImageDetailsCopyWith<$Res> get full;
  @override
  $ImageDetailsCopyWith<$Res> get large;
  @override
  $ImageDetailsCopyWith<$Res> get medium;
  @override
  $ImageDetailsCopyWith<$Res> get small;
}

/// @nodoc
class __$$_CloudImageCopyWithImpl<$Res>
    extends _$CloudImageCopyWithImpl<$Res, _$_CloudImage>
    implements _$$_CloudImageCopyWith<$Res> {
  __$$_CloudImageCopyWithImpl(
      _$_CloudImage _value, $Res Function(_$_CloudImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? full = null,
    Object? large = null,
    Object? medium = null,
    Object? small = null,
  }) {
    return _then(_$_CloudImage(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      full: null == full
          ? _value.full
          : full // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as ImageDetails,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CloudImage extends _CloudImage {
  _$_CloudImage(
      {required this.hash,
      required this.full,
      required this.large,
      required this.medium,
      required this.small})
      : super._();

  factory _$_CloudImage.fromJson(Map<String, dynamic> json) =>
      _$$_CloudImageFromJson(json);

  @override
  final String hash;
  @override
  final ImageDetails full;
  @override
  final ImageDetails large;
  @override
  final ImageDetails medium;
  @override
  final ImageDetails small;

  @override
  String toString() {
    return 'CloudImage(hash: $hash, full: $full, large: $large, medium: $medium, small: $small)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CloudImage &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.full, full) || other.full == full) &&
            (identical(other.large, large) || other.large == large) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.small, small) || other.small == small));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hash, full, large, medium, small);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CloudImageCopyWith<_$_CloudImage> get copyWith =>
      __$$_CloudImageCopyWithImpl<_$_CloudImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CloudImageToJson(
      this,
    );
  }
}

abstract class _CloudImage extends CloudImage {
  factory _CloudImage(
      {required final String hash,
      required final ImageDetails full,
      required final ImageDetails large,
      required final ImageDetails medium,
      required final ImageDetails small}) = _$_CloudImage;
  _CloudImage._() : super._();

  factory _CloudImage.fromJson(Map<String, dynamic> json) =
      _$_CloudImage.fromJson;

  @override
  String get hash;
  @override
  ImageDetails get full;
  @override
  ImageDetails get large;
  @override
  ImageDetails get medium;
  @override
  ImageDetails get small;
  @override
  @JsonKey(ignore: true)
  _$$_CloudImageCopyWith<_$_CloudImage> get copyWith =>
      throw _privateConstructorUsedError;
}
