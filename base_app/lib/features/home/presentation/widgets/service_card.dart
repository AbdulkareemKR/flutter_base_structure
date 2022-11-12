import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_svg_icons.dart';
import 'package:garage_client/features/home/domain/providers/car_min_price_provider.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/gard_gesture_detector.dart';
import 'package:garage_core/models/service.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';
import 'package:garage_core/widgets/images/svg_image.dart';

class ServiceCard extends ConsumerWidget {
  const ServiceCard({
    Key? key,
    required this.onServiceClick,
    required this.service,
  }) : super(key: key);

  BorderRadius _getBorderRadiusFromLocale() {
    switch (App.lang) {
      case 'ar':
        return BorderRadius.only(topLeft: Radius.circular(14.sp), bottomRight: Radius.circular(14.sp));
      default:
        return BorderRadius.only(topRight: Radius.circular(14.sp), bottomLeft: Radius.circular(14.sp));
    }
  }

  final void Function(Service service) onServiceClick;
  final Service service;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GuardGestureDetector(
      onTap: () {
        onServiceClick(service);
      },
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: SvgImage(
                  imagePath: GarageSvgIcons.smallCar,
                  fit: BoxFit.fitWidth,
                  paddingSize: 7.h,
                ),
                margin: EdgeInsets.only(top: 11.h, left: 11.w, right: 11.w),
                decoration: BoxDecoration(color: ColorsConst.cultured, borderRadius: BorderRadius.circular(6.w)),
                width: 32.w,
                height: 32.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.49.w),
                child: Text(service.name.translated,
                    style: context.textThemes.bodyMedium?.copyWith(
                      color: ColorsConst.cosmicCobalt,
                    )),
              ),
              Container(
                child: Center(
                  child: ref.watch(carMinPriceProvider(service)).when(data: (data) {
                    return Text('home.startsFrom'.translate() + ' ${data.toInt()} ' + 'sar'.translate(),
                        style: context.textThemes.displaySmall?.regular.copyWith(color: ColorsConst.white),
                        textAlign: TextAlign.start);
                  }, error: ((error, stackTrace) {
                    error.logException(stackTrace: stackTrace);

                    return const SizedBox.shrink();
                  }), loading: () {
                    return SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
                width: 113.39.w,
                height: 34.67.h,
                decoration: BoxDecoration(color: ColorsConst.cosmicCobalt, borderRadius: _getBorderRadiusFromLocale()),
              )
            ]),
        width: 155.w,
        height: 125.h,
        decoration: BoxDecoration(
            color: ColorsConst.white,
            borderRadius: BorderRadius.circular(13.sp),
            boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
      ),
    );
  }
}
