import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/models/async_response/async_response.dart';

part 'locale_response.freezed.dart';

@freezed
class LocaleResponse extends AsyncResponse with _$LocaleResponse  {
  const factory LocaleResponse({required bool success, String? message, dynamic data}) = _LocaleResponse;
}
