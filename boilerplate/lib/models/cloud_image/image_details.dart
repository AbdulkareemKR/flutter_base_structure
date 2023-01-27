
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_details.freezed.dart';
part 'image_details.g.dart';

@freezed
class ImageDetails with _$ImageDetails {
  factory ImageDetails({required String url}) = _ImageDetails;
	
  factory ImageDetails.fromJson(Map<String, dynamic> json) =>
			_$ImageDetailsFromJson(json);
}
