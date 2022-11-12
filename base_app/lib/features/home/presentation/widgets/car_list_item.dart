import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/global_providers/car_name_provider.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/global_services/models/user_car.dart';

class CarListItem extends ConsumerWidget {
  const CarListItem({
    Key? key,
    required this.car,
    required this.onCarClick,
  }) : super(key: key);

  final UserCar car;
  final void Function() onCarClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onCarClick,
      child: SizedBox(
        width: 100.sw,
        height: 200.h,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            /// FIXME: add the real car image
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Image.asset('assets/images/car.png'),
            ),
            Positioned(
                left: 33.w,
                child: Column(
                  children: [
                    Text(
                      ref.watch(carNameProvider(car.carId ?? '')).when(
                          data: (carName) => carName,
                          error: ((error, stackTrace) {
                            log('$error');
                            return '';
                          }),
                          loading: (() => '')),
                      style: context.textThemes.bodySmall?.regular.copyWith(color: ColorsConst.cosmicCobalt),
                    ),
                    Text(
                      car.plate?.getPlate(App.lang) ?? '',
                      style: context.textThemes.displaySmall?.regular,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
