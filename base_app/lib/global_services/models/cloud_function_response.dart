import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_core/models/async_response/async_response.dart';

part 'cloud_function_response.freezed.dart';
part 'cloud_function_response.g.dart';

@freezed
class CloudFunctionsResponse extends AsyncResponse with _$CloudFunctionsResponse {
  factory CloudFunctionsResponse({required bool success, required String message, required dynamic data}) =
      _CloudFunctionsResponse;

  factory CloudFunctionsResponse.fromJson(Map<String, dynamic> json) => _$CloudFunctionsResponseFromJson(json);
  factory CloudFunctionsResponse.fromJsonString(String json) => _$CloudFunctionsResponseFromJson(jsonDecode(json));
}
