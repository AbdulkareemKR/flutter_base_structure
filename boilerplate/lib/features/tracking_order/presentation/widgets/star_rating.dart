import 'package:flutter/material.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/spacing_const.dart';

class StarRating extends StatelessWidget {
  final void Function(int) changeRatingHandler;
  final double size;
  final int numberOfStars;
  final int rating;
  final Color color;

  const StarRating({
    Key? key,
    this.numberOfStars = 5,
    required this.rating,
    this.color = Colors.black,
    this.size = 35,
    required this.changeRatingHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            numberOfStars,
            (index) => Padding(
              padding: EdgeInsets.all(SpacingConst.spacing6.w),
              child: GestureDetector(
                child: index >= rating
                    ? Icon(
                        GarageIcons.Star,
                        color: ColorsConst.lightGrey,
                        size: size.h,
                      )
                    : Padding(
                        padding: EdgeInsets.all(4.h),
                        child: Icon(
                          // TODO: add colored icon from the deisign
                          GarageIcons.ColoredStar,
                          color: color,
                          size: size.h - 8.h,
                        ),
                      ),
                onTap: () {
                  // +1 because the index of the stars starts from 0
                  changeRatingHandler(index + 1);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
