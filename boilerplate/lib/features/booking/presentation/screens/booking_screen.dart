import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/booking/domain/models/timeslot_group.dart';
import 'package:garage_client/features/booking/domain/providers/container_height_proivder.dart';
import 'package:garage_client/features/booking/domain/providers/order_from_state_notifier.dart';
import 'package:garage_client/features/booking/domain/providers/sub_services_provider.dart';
import 'package:garage_client/features/booking/domain/providers/timelosts_future_provider.dart';
import 'package:garage_client/features/booking/presentation/screens/booking_screen_form.dart';
import 'package:garage_client/features/booking/presentation/screens/no_timeslot_widget.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/animated_dialog.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_size.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/models/timeslot.dart';
import 'package:garage_client/services/date_time_repo.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:garage_client/widgets/bottom_sheet/bottom_sheet_navigator.dart';
import 'package:garage_client/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_client/widgets/loading_container.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({Key? key, required this.service}) : super(key: key);

  final Service service;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderFormProvider(widget.service.id));

    return state.build(((data) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.service.name.translated,
                style: context.textThemes.titleMedium,
              ),
              SizedBox(
                height: 33.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.5.w),
                height: 170.h,
                width: 330.w,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'booking.serviceType'.translate(),
                    style: context.textThemes.bodyMedium,
                  ),
                  SpacingConst.vSpacing8,
                  Consumer(builder: (context, ref, child) {
                    return ref.watch(subServicesProvider(widget.service.id)).when(data: (servicesList) {
                      return CustomDropDown<Service>(
                        text: data.selectedService?.name.translated ?? '',
                        values: List.generate(
                            servicesList.length,
                            (index) =>
                                CustomChoice(value: servicesList[index], text: servicesList[index].name.translated)),
                        onChange: ref.read(orderFormProvider(widget.service.id).notifier).changeSelectedService,
                      );
                    }, error: (error, stackTrace) {
                      error.logException();
                      return const SizedBox.shrink();
                    }, loading: () {
                      return LoadingContainer(
                        width: 288.w,
                        height: 38.h,
                      );
                    });
                  }),
                  SpacingConst.vSpacing8,
                  Text(
                    'booking.otherService'.translate(),
                    style: context.textThemes.bodyMedium,
                  ),
                  SpacingConst.vSpacing8,
                  Consumer(builder: (context, ref, child) {
                    return ref.watch(subServicesProvider(data.selectedService?.id ?? '')).when(data: (servicesList) {
                      return CustomDropDown<Service?>(
                        text: data.otherServices?.name.translated ?? 'doesNotExist'.translate(),
                        values: <CustomChoice<Service?>>[CustomChoice(value: null, text: 'doesNotExist'.translate())] +
                            List<CustomChoice<Service?>>.generate(
                                servicesList.length,
                                (index) => CustomChoice(
                                    value: servicesList[index], text: servicesList[index].name.translated)),
                        onChange: ref.read(orderFormProvider(widget.service.id).notifier).changeSelectedOtherService,
                      );
                    }, error: (error, stackTrace) {
                      error.logException();
                      return const SizedBox.shrink();
                    }, loading: () {
                      return LoadingContainer(
                        width: 288.w,
                        height: 38.h,
                      );
                    });
                  }),
                ]),
                decoration: BoxDecoration(
                    color: ColorsConst.white,
                    borderRadius: BorderRadius.circular(14.sp),
                    boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
              ),
              SpacingConst.vSpacing16,
              Container(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'booking.notes'.translate(),
                    style: context.textThemes.bodyMedium,
                  ),
                  SpacingConst.vSpacing8,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(color: ColorsConst.cultured, borderRadius: BorderRadius.circular(10.sp)),
                    height: 101.h,
                    width: 288.w,
                    child: TextField(
                        maxLines: 3,
                        style: context.textThemes.bodySmall?.regular,
                        decoration: InputDecoration(
                          hintText: 'booking.writeNotesHere'.translate(),
                          border: InputBorder.none,
                          hintStyle: context.textThemes.bodySmall?.regular.copyWith(color: ColorsConst.lightGrey),
                        )),
                  )
                ]),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.5.w),
                width: 329.w,
                decoration: BoxDecoration(
                    color: ColorsConst.white,
                    borderRadius: BorderRadius.circular(14.sp),
                    boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
              ),
              const Spacer(),
              ConditionaryWidget(
                  condition: data.timeslot != null,
                  trueWidget: Text('booking.expectedPrice'.translate(arguments: [data.totalPrice.toStringAsFixed(2)]))),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
          Visibility(
            visible: ref.watch(containerStateProvider),
            child: OverflowBox(
              maxHeight: 1000.h,
              child: ModalBarrier(
                onDismiss: () {
                  ref.watch(containerStateProvider.state).state = !ref.watch(containerStateProvider);
                },
                color: Colors.black38,
              ),
            ),
          ),
          Positioned(
            bottom: 36.h,
            child: Consumer(builder: (context, ref, child) {
              return ref
                  .watch(getTimeslotsProvider(
                      data.selectedService?.id, ref.watch(carOwnerProvider).asData!.value!.defaultCar!))
                  .when(
                data: (timeslots) {
                  return AnimatedContainer(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 13.6.w),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  /// Check if [selectedDate] is not null
                                  ///
                                  if (data.date != null) {
                                    /// if true
                                    ///
                                    /// set selectedDate to null
                                    ref.read(orderFormProvider(widget.service.id).notifier).changeSelectedDate(null);
                                  } else {
                                    /// if false
                                    ///
                                    /// dispose the container
                                    ref.watch(containerStateProvider.state).state = false;
                                  }
                                },
                                child: Icon(
                                  arrowBackward(context),
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(
                                width: 14.5.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'booking.availableTimeslots'.translate(),
                                    style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.dartGrey),
                                  ),
                                  Text('booking.selectTimeslot'.translate(),
                                      style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.blackCoral)),
                                ],
                              )
                            ],
                          ),
                          SpacingConst.vSpacing6,
                          SpacingConst.vSpacing6,
                          SizedBox(
                            height: 150.h,
                            width: 336.w,
                            child: ref.read(orderFormProvider(widget.service.id).notifier).showTimePicker
                                ? TimePicker(
                                    onTimePicked:
                                        ref.read(orderFormProvider(widget.service.id).notifier).changeSelectedTimeslot,
                                    dates: timeslots[data.date] ?? [],
                                  )
                                : DatePicker(
                                    onDatePicked:
                                        ref.read(orderFormProvider(widget.service.id).notifier).changeSelectedDate,
                                    dates: timeslots.keys.toList(),
                                  ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.sp), color: ColorsConst.white),
                    duration: const Duration(milliseconds: 300),
                    width: 336.w,
                    height: ref.watch(containerStateProvider) ? 278.h : 0.0,
                  );
                },
                error: (error, stackTrace) {
                  error.logException();
                  return const SizedBox.shrink();
                },
                loading: () {
                  return const SizedBox.shrink();
                },
              );
            }),
          ),
          Positioned(
            bottom: 45.h,
            child: Consumer(builder: (context, ref, child) {
              return ref
                  .watch(getTimeslotsProvider(
                      data.selectedService?.id, ref.watch(carOwnerProvider).asData!.value!.defaultCar!))
                  .when(
                data: (timeslots) {
                  return CustomButton(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50.w,
                        ),
                        Text('booking.book'.translate(),
                            style: context.textThemes.bodyMedium?.copyWith(
                              color: ColorsConst.white,
                            )),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            ref.read(containerStateProvider.state).state = !ref.read(containerStateProvider);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  (data.date?.split(' ').first ?? '') +
                                      ',\n' +
                                      (data.timeslot != null
                                          ? ref.read(dateTimeRepo).getHourTimeRange(
                                              data.timeslot!.dateFrom, data.timeslot!.dateTo,
                                              localeCode: App.localeCode)
                                          : ''),
                                  style: context.textThemes.bodySmall,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                GarageIcons.Arrow___Down_2,
                                size: 20.sp,
                              )
                            ]),
                            decoration:
                                BoxDecoration(color: ColorsConst.white, borderRadius: BorderRadius.circular(10.sp)),
                            width: 130.w,
                            height: 36.h,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      if (data.timeslot != null) {
                        ref
                            .read(bookingPageControllerProvider)
                            .animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInBack);
                      } else {
                        GarageDialog.show(
                            context: context, style: DialogStyle.error, message: 'cars.fillAllFields'.translate());
                      }
                    },
                    size: ButtonSize.large,
                    style: CustomButtonStyle.primary,
                  );
                },
                error: (error, stackTrace) {
                  error.logException();
                  return const SizedBox.shrink();
                },
                loading: () {
                  return LoadingContainer(
                    width: 317.w,
                    height: 50.h,
                  );
                },
              );
            }),
          ),
        ],
      );
    }), onError: (error, stackTrace) {
      error.logException();
      return const NoTimeslotWidget();
    });
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.dates,
    required this.onDatePicked,
  }) : super(key: key);

  final List<String> dates;
  final void Function(String) onDatePicked;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 150.h, mainAxisSpacing: 8.w, crossAxisSpacing: 15),
        itemCount: widget.dates.length,
        itemBuilder: ((context, index) {
          return DateItem(
            date: widget.dates[index],
            onClick: () {
              widget.onDatePicked(widget.dates[index]);
            },
          );
        }));
  }
}

class TimePicker extends ConsumerWidget {
  const TimePicker({Key? key, required this.dates, required this.onTimePicked}) : super(key: key);

  final List<TimeslotGroup> dates;
  final void Function(Timeslot) onTimePicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 150.h, mainAxisSpacing: 8.w, crossAxisSpacing: 15),
        itemCount: dates.length,
        itemBuilder: ((context, index) {
          return DateItem(
            date: dates[index].durationString,
            onClick: () {
              onTimePicked(dates[index].timeslots.first);
              ref.read(containerStateProvider.state).state = false;
            },
          );
        }));
  }
}

class DateItem extends ConsumerStatefulWidget {
  const DateItem({
    required this.onClick,
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;
  final void Function() onClick;

  @override
  ConsumerState<DateItem> createState() => _DateItemState();
}

class _DateItemState extends ConsumerState<DateItem> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isChecked = true;
        });
        await Future.delayed(const Duration(milliseconds: 200));
        widget.onClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        child: Center(
            child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(widget.date,
              textDirection: TextDirection.ltr,
              style: context.textThemes.bodyMedium?.regular.copyWith(
                color: _isChecked ? ColorsConst.cosmicCobalt : ColorsConst.dartGrey,
              )),
        )),
        width: 150.2.w,
        height: 38.h,
        decoration: BoxDecoration(
            color: _isChecked ? ColorsConst.cosmicCobalt.shade100 : ColorsConst.cultured,
            borderRadius: BorderRadius.circular(10.sp)),
      ),
    );
  }
}

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.text,
    required this.values,
    required this.onChange,
  }) : super(key: key);

  final String text;
  final List<CustomChoice<T>> values;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final returnedValue = await showCustomBottomSheet<T>(
            context: context,
            isFullBottomSheet: false,
            child: ChoicesWidget(
              choices: values,
            ));

        onChange(returnedValue);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        child: Row(children: [
          Text(text,
              style: context.textThemes.bodySmall?.copyWith(
                color: ColorsConst.cosmicCobalt,
              )),
          const Spacer(),
          const Icon(
            GarageIcons.Arrow___Down_2,
            color: ColorsConst.dartGrey,
          )
        ]),
        height: 38.h,
        width: 288.w,
        decoration: BoxDecoration(color: ColorsConst.cultured, borderRadius: BorderRadius.circular(10.sp)),
      ),
    );
  }
}

class ChoicesWidget<T> extends StatelessWidget {
  const ChoicesWidget({
    required this.choices,
    Key? key,
  }) : super(key: key);

  final List<CustomChoice<T>> choices;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: choices),
      margin: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.sp)),
      width: 336.w,
    );
  }
}

class CustomChoice<T> extends StatefulWidget {
  const CustomChoice({
    Key? key,
    required this.value,
    required this.text,
  }) : super(key: key);

  final T value;
  final String text;

  @override
  State<CustomChoice<T>> createState() => _CustomChoiceState<T>();
}

class _CustomChoiceState<T> extends State<CustomChoice<T>> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() async {
        HapticFeedback.mediumImpact();
        setState(() {
          _isClicked = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));
        Navigator.of(context).pop(widget.value);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        child: Text(widget.text,
            style: context.textThemes.bodySmall?.copyWith(
              color: ColorsConst.cosmicCobalt,
            )),
        height: 38.h,
        width: 288.w,
        decoration: BoxDecoration(
            color: _isClicked ? ColorsConst.cosmicCobalt.shade100 : ColorsConst.cultured,
            borderRadius: BorderRadius.circular(10.sp)),
      ),
    );
  }
}
