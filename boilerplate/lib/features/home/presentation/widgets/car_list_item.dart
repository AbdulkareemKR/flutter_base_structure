import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/features/home/presentation/controllers/car_image_controller.dart';
import 'package:garage_client/global_providers/car_name_provider.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/models/user_car.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:garage_client/widgets/image_viewer/cloud_image_card.dart';
import 'package:garage_client/widgets/loading_container.dart';

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
    final carImage = ref.watch(carImageProvider(car.carId!));

    return GestureDetector(
      onTap: onCarClick,
      child: SizedBox(
        width: 100.sw,
        height: 200.h,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: carImage.when(
                data: (image) {
                  return CloudImageCard(
                    image: image!,
                  );
                },
                loading: () => LoadingContainer(
                  width: 288.w,
                  height: 38.h,
                ),
                error: (error, stackTrace) {
                  GLogger.error('$error');
                  return const SizedBox.shrink();
                },
              ),
            ),
            Positioned(
                left: 33.w,
                child: Column(
                  children: [
                    Text(
                      ref.watch(carNameProvider(car.carId ?? '')).when(
                          data: (carName) => carName,
                          error: ((error, stackTrace) {
                            error.logException();
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
