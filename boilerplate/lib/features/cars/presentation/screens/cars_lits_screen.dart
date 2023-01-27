import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/features/cars/presentation/screens/add_cars_screen.dart';
import 'package:garage_client/features/home/presentation/controllers/car_image_controller.dart';
import 'package:garage_client/global_providers/car_name_provider.dart';
import 'package:garage_client/global_providers/user_cars_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/models/cloud_image/image_resolution_options.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:garage_client/widgets/bottom_sheet/bottom_sheet_navigator.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/widgets/image_viewer/cloud_image_card.dart';
import 'package:garage_client/widgets/loading_container.dart';

class CarsListScreen extends ConsumerStatefulWidget {
  const CarsListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarsListScreenState();
}

class _CarsListScreenState extends ConsumerState<CarsListScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userCarsProvider);

    return state.build((carState) {
      return Sheet(
        title: 'cars.myCars'.translate(),
        children: [
          SizedBox(
            height: 580.h,
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(carState.length, (index) {
                final carImage = ref.watch(carImageProvider(
                    carState[index].carId!)); //TODO: Better handling of the user car in case of null values

                return GestureDetector(
                  onTap: (() {
                    showCustomBottomSheet(
                        context: context,
                        child: AddCarsScreen(
                          userCar: carState[index],
                        ));
                  }),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    width: 305.w,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            carImage.when(
                              data: (image) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                                  child: CloudImageCard(
                                    image: image!,
                                    resolutionOptions: ImageResolutionOptions.medium,
                                  ),
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
                            Text(
                              ref.watch(carNameProvider(carState[index].carId ?? '')).when(
                                  data: (carName) => carName,
                                  error: ((error, stackTrace) {
                                    error.logException();
                                    return '';
                                  }),
                                  loading: (() => '')),
                              style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                            ),
                            Text(
                              carState[index].plate?.getPlate(App.lang) ?? '',
                              style: context.textThemes.displaySmall?.regular,
                            ),
                          ],
                        ),
                        Positioned(
                            bottom: 11.h,
                            left: 17.w,
                            child: Row(
                              children: [
                                Text('cars.details'.translate(), style: context.textThemes.displaySmall?.light),
                                Icon(GarageIcons.Arrow_Left, size: 15.sp)
                              ],
                            ))
                      ],
                    ),
                    height: 180.h,
                    decoration: BoxDecoration(
                        color: ColorsConst.white,
                        borderRadius: BorderRadius.circular(20.sp),
                        boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.08), blurRadius: 10)]),
                  ),
                );
              })),
            ),
          ),
        ],
        footer: [
          Center(
            child: CustomButton(
                label: 'cars.addNewCar'.translate(),
                icon: GarageIcons.Add,
                onPressed: () {
                  showCustomBottomSheet(context: context, child: const AddCarsScreen());
                }),
          ),
        ],
      );
    });
  }
}
