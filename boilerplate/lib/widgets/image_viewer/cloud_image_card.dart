import 'package:flutter/material.dart';
import 'package:garage_client/animations/show_up.dart';
import 'package:garage_client/animations/animations.dart';
import 'package:garage_client/models/cloud_image/cloud_image.dart';
import 'package:garage_client/models/cloud_image/image_resolution_options.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CloudImageCard extends StatefulWidget {
  const CloudImageCard({Key? key, required this.image, this.resolutionOptions = ImageResolutionOptions.large})
      : super(key: key);

  final CloudImage image;
  final ImageResolutionOptions resolutionOptions;

  @override
  State<CloudImageCard> createState() => _CloudImageCardState();
}

class _CloudImageCardState extends State<CloudImageCard> {
  @override
  Widget build(BuildContext context) {
    return ShowUp(
      child: AspectRatio(
        aspectRatio: 16 / 7.5,
        child: CachedNetworkImage(
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
          imageUrl: widget.image.getImageByResolution(widget.resolutionOptions),
          fadeInCurve: Curves.linear,
        ),
      ),
    );
  }
}
