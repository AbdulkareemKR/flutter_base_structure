import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:jovial_svg/jovial_svg.dart';

/// Render a high quality SVG image
class SvgImage extends StatelessWidget {
  const SvgImage({Key? key, required this.imagePath, this.scale = 1, this.fit = BoxFit.none, this.paddingSize = 0})
      : super(key: key);

  /// The path of the SVG image
  final String imagePath;

  /// Used to scale the image.
  final double scale;

  final BoxFit fit;

  final double paddingSize;

  @override
  Widget build(BuildContext context) {
    //TODO: Convert SVG to SI see https://pub.dev/documentation/jovial_svg/latest/jovial_svg/ScalableImageSource/fromSvg.html
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: ScalableImageWidget.fromSISource(
        si: ScalableImageSource.fromSvg(rootBundle, imagePath),
        scale: scale,
        fit: fit,
      ),
    );
  }
}
