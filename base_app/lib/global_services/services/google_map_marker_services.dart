import 'dart:ui' as ui; // imported as ui to prevent conflict between ui.Image and the Image widget
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    {required BuildContext context, required String assetPath, double size = 5}) async {
  // Read SVG file as String
  String svgString = await DefaultAssetBundle.of(context).loadString(assetPath);
  // Create DrawableRoot from SVG String
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, svgString);

  double width = size;
  double height = size;
  ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

  // Convert to toImage() then to byteData
  ui.Image image = await picture.toImage(width.toInt(), height.toInt());
  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}
