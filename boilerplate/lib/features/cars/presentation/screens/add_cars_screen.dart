import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/cars/domain/enums/car_view_mode.dart';
import 'package:garage_client/features/cars/domain/providers/cars_provider.dart';
import 'package:garage_client/features/cars/domain/providers/color_page_index_provider.dart';
import 'package:garage_client/features/cars/domain/providers/colors_provider.dart';
import 'package:garage_client/features/cars/presentation/controllers/cars_state_notifier.dart';
import 'package:garage_client/features/cars/presentation/controllers/plate_formatter.dart';
import 'package:garage_client/features/cars/presentation/controllers/plate_number_formatter.dart';
import 'package:garage_client/features/cars/presentation/widget/car_widget.dart';
import 'package:garage_client/features/cars/presentation/widget/empty_color.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_dropdown.dart';
import 'package:garage_client/widgets/selected_indecator.dart';
import 'package:garage_client/models/car.dart';
import 'package:garage_client/models/color.dart';
import 'package:garage_client/models/translatable.dart';
import 'package:garage_client/models/user_car.dart';
import 'package:garage_client/utils/logger/extensions.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/widgets/conditionary_widget/widgets/conditionary_widget.dart';
import 'package:garage_client/widgets/loading_container.dart';

class AddCarsScreen extends ConsumerStatefulWidget {
  const AddCarsScreen({Key? key, this.userCar}) : super(key: key);

  final UserCar? userCar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCarsScreenState();
}

class _AddCarsScreenState extends ConsumerState<AddCarsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(carStateProvider(widget.userCar));

    return state.build((carStateInfo) {
      final _controller = ref.read(carStateProvider(widget.userCar).notifier);
      return Sheet(
          title: carStateInfo.viewMode == CarViewMode.add ? 'cars.addNewCar'.translate() : 'cars.editCar'.translate(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.5.w),
              height: 170.h,
              width: 330.w,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'cars.selectCarCompany'.translate(),
                  style: context.textThemes.bodyMedium,
                ),
                SpacingConst.vSpacing8,
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(carsProvider).when(
                      data: (cars) {
                        final keys = cars.keys.toList();
                        return CustomDropDown(
                            text: carStateInfo.carBrand.translated,
                            values: List.generate(
                                keys.length, (index) => CustomChoice(value: keys[index], text: keys[index].translated)),
                            onChange: (Translatable carCompany) {
                              _controller.changeSelectedCarCompany(carCompany);
                            });
                      },
                      loading: () {
                        return LoadingContainer(
                          width: 288.w,
                          height: 40.h,
                        );
                      },
                      error: (error, stackTrace) {
                        error.logException();
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
                SpacingConst.vSpacing16,
                Text(
                  'cars.selectCarBrand'.translate(),
                  style: context.textThemes.bodyMedium,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(carsProvider).when(
                      data: (cars) {
                        final values = cars[carStateInfo.carBrand];
                        return CustomDropDown<Car>(
                            text: carStateInfo.carType,
                            values: List.generate(values!.length,
                                (index) => CustomChoice(value: values[index], text: values[index].brand.translated)),
                            onChange: (car) {
                              _controller.changeSelectedCarBrand(car);
                            });
                      },
                      loading: () {
                        return LoadingContainer(
                          width: 288.w,
                          height: 40.h,
                        );
                      },
                      error: (error, stackTrace) {
                        error.logException();
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ]),
              decoration: BoxDecoration(
                  color: ColorsConst.white,
                  borderRadius: BorderRadius.circular(14.sp),
                  boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
            ),
            SpacingConst.vSpacing16,
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.5.w),
              width: 330.w,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'cars.carColor'.translate(),
                  style: context.textThemes.bodyMedium,
                ),
                SpacingConst.vSpacing8,
                ColorPicker(controller: _controller, selectedColor: carStateInfo.selectedColor),
              ]),
              decoration: BoxDecoration(
                  color: ColorsConst.white,
                  borderRadius: BorderRadius.circular(14.sp),
                  boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
            ),
            SpacingConst.vSpacing16,
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.5.w),
              width: 330.w,
              height: 86.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'cars.carPlate'.translate(),
                    style: context.textThemes.bodyMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 135.w,
                        height: 34.h,
                        child: TextField(
                            controller: _controller.lettersController,
                            autocorrect: false,
                            style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              PlateFormatter(),
                              LengthLimitingTextInputFormatter(5),
                            ],
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'cars.platePlaceHolder'.translate(),
                                hintStyle: context.textThemes.bodySmall?.regular)),
                      ),
                      Text(
                        '|',
                        style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.lightGrey),
                      ),
                      SizedBox(
                          width: 135.w,
                          height: 34.h,
                          child: TextField(
                            controller: _controller.numbersController,
                            autocorrect: false,
                            style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [PlateNumberFormatter()],
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '1234',
                                hintStyle: context.textThemes.bodySmall?.regular),
                          ))
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: ColorsConst.white,
                  borderRadius: BorderRadius.circular(14.sp),
                  boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
            ),
          ],
          footer: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: ConditionaryWidget(
                  condition: carStateInfo.viewMode == CarViewMode.add,
                  trueWidget: CustomButton(
                      label: 'add'.translate(),
                      icon: GarageIcons.Add,
                      onPressed: () async {
                        await _controller.onAddCarClick(context);
                      }),
                  falseWidget: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            label: 'cars.deleteCar'.translate(),
                            icon: GarageIcons.Delete,
                            onPressed: () async {
                              await _controller.onDeleteClick(context);
                            },
                            color: ColorsConst.negativeRed,
                          ),
                          SpacingConst.vSpacing16,
                          CustomButton(
                            label: 'save'.translate(),
                            icon: GarageIcons.Add,
                            onPressed: () async {
                              await _controller.onSaveChangesClick(context);
                            },
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ]);
    });
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
    required CarsStateNotifier controller,
    required this.selectedColor,
  })  : _controller = controller,
        super(key: key);

  final CarsStateNotifier _controller;
  final CarColor? selectedColor;

  int _getItemCount(int originalColorCount) {
    ///add [originalColorCount] % 8 to the [originalColorCount]
    ///
    /// Because we are displaying 8 in each page.
    return originalColorCount + (originalColorCount % 8);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(builder: (context, ref, child) {
        return ref.watch(colorsProvider).build((colors) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 281.w,
                height: 130.h,
                child: GridView.builder(
                  controller: _controller.colorPageController,
                  itemCount: _getItemCount(colors.length),
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 48.w, mainAxisSpacing: 24.w, crossAxisSpacing: 10.h),
                  itemBuilder: (context, index) {
                    if (index < colors.length) {
                      return ColorWidget(
                        onPressed: (color) {
                          _controller.onColorClick(color);
                        },
                        isSelected: selectedColor == colors[index],
                        color: colors[index],
                      );
                    } else {
                      return const EmptyColor();
                    }
                  },
                ),
              ),
              SelectedIndicator(
                count: (colors.length / 8).ceil(),
                selected: ref.watch(colorPageIndexProvider),
              )
            ],
          );
        });
      }),
    );
  }
}
