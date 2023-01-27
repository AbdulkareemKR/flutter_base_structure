// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CloudImage _$$_CloudImageFromJson(Map<String, dynamic> json) =>
    _$_CloudImage(
      hash: json['hash'] as String,
      full: ImageDetails.fromJson(json['full'] as Map<String, dynamic>),
      large: ImageDetails.fromJson(json['large'] as Map<String, dynamic>),
      medium: ImageDetails.fromJson(json['medium'] as Map<String, dynamic>),
      small: ImageDetails.fromJson(json['small'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CloudImageToJson(_$_CloudImage instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'full': instance.full,
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
    };
