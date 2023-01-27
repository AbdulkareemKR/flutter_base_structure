import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/models/cloud_image/image_details.dart';
import 'package:garage_client/models/cloud_image/image_resolution_options.dart';

part 'cloud_image.freezed.dart';
part 'cloud_image.g.dart';

@freezed
class CloudImage with _$CloudImage {
  const CloudImage._();

  factory CloudImage(
      {required String hash,
      required ImageDetails full,
      required ImageDetails large,
      required ImageDetails medium,
      required ImageDetails small}) = _CloudImage;

  factory CloudImage.fromJson(Map<String, dynamic> json) => _$CloudImageFromJson(json);

  String getImageByResolution(ImageResolutionOptions resolution) {
    switch (resolution) {
      case ImageResolutionOptions.full:
        return full.url;
      case ImageResolutionOptions.large:
        return large.url;
      case ImageResolutionOptions.medium:
        return medium.url;
      case ImageResolutionOptions.small:
        return small.url;
    }
  }
}
