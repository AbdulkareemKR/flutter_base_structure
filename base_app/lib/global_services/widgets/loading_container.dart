import 'package:flutter/material.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  /// height in [Sizer]
  final double height;

  /// width in [Sizer]
  final double width;
  const LoadingContainer({
    Key? key,
    this.height = 7,
    this.width = 85,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(seconds: 1),
        baseColor: ServiceProviderColors.clutured,
        highlightColor: Colors.grey.shade200,
        enabled: true,
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(color: Colors.grey, borderRadius: smallBorderRadius),
        ));
  }
}
