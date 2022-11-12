import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/features/cars/presentation/screens/add_cars_screen.dart';
import 'package:garage_client/global_providers/car_name_provider.dart';
import 'package:garage_client/global_providers/user_cars_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_core/models/user_car.dart';
import 'package:garage_core/utilis/logger/extensions.dart';
import 'package:garage_core/widgets/bottom_sheet/bottom_sheet_navigator.dart';
import 'package:garage_core/widgets/bottom_sheet/utils/sheet.dart';

class CarsListScreen extends ConsumerStatefulWidget {
  const CarsListScreen({Key? key, this.userCar}) : super(key: key);

  final UserCar? userCar;

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
                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset(
                            'assets/images/car.png',
                            width: 191.w,
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
                        ]),
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
