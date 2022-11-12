import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class ExpandableContainer extends StatefulWidget {
  final double initialHeight;
  final double expandedHeight;
  bool isExpanded;
  final Widget title;
  final Widget details;
  final int duration;
  final double? width;

  ExpandableContainer({
    Key? key,
    required this.initialHeight,
    this.isExpanded = false,
    required this.title,
    required this.details,
    this.duration = 400,
    required this.expandedHeight,
    this.width,
  }) : super(key: key);

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.duration),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing16.toDouble()),
        height: !widget.isExpanded ? widget.initialHeight : widget.expandedHeight,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: smallBorderRadius,
          border: Border.all(
            color: ColorsConst.disableGrey,
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.title,
                  Icon(
                    widget.isExpanded ? GarageIcons.Arrow_Up : GarageIcons.Arrow___Down_2,
                    size: 25.sp,
                    color: ColorsConst.dartGrey,
                  ),
                ],
              ),
              SpacingConst.vSpacing6,
              Container(
                child: widget.details,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        setState(() {
          widget.isExpanded = !widget.isExpanded;
        });
      },
    );
  }
}
