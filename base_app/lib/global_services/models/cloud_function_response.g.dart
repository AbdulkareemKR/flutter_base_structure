// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_function_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CloudFunctionsResponse _$$_CloudFunctionsResponseFromJson(
        Map<String, dynamic> json) =>
    _$_CloudFunctionsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$_CloudFunctionsResponseToJson(
        _$_CloudFunctionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
