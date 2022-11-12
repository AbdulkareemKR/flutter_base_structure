import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/booking/domain/models/available_service_data.dart';
import 'package:garage_client/features/booking/domain/providers/order_from_state_notifier.dart';
import 'package:garage_client/features/booking/domain/providers/available_service_provider.dart';
import 'package:garage_client/features/booking/presentation/screens/booking_screen.dart';
import 'package:garage_client/features/booking/presentation/screens/booking_screen_form.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/global_providers/city_name_provider.dart';
import 'package:garage_client/global_providers/payment_methods_proivder.dart';
import 'package:garage_client/global_providers/wallet_provider.dart';
import 'package:garage_client/localization/controllers.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_size.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/widgets/garage_divider.dart';
import 'package:garage_client/widgets/radio_button/radio_button.dart';
import 'package:garage_client/global_services/enums/currency.dart';
import 'package:garage_client/global_services/models/service.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/global_services/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_client/global_services/widgets/loading_container.dart';
import 'package:garage_client/global_services/widgets/price_text.dart';

class ReviewBookingScreen extends ConsumerStatefulWidget {
  const ReviewBookingScreen({Key? key, required this.service}) : super(key: key);

  final Service service;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends ConsumerState<ReviewBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderFormProvider(widget.service.id));

    return state.build(((orderInfo) {
      final _controller = ref.read(orderFormProvider(widget.service.id).notifier);
      final paymentMethods = ref.watch(paymentMethodsProvider);

      return Sheet(
        appBar: AppBar(
          title: Text(
            'booking.bookingReview'.translate(),
            style: context.textThemes.titleMedium,
          ),
          leading: GestureDetector(
            onTap: () {
              ref
                  .read(bookingPageControllerProvider)
                  .animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInBack);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                width: 25.w,
                child: Icon(
                  arrowBackward(context),
                  size: 28.sp,
                  color: ColorsConst.black,
                ),
              ),
            ),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            width: 330.w,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'booking.carLocation'.translate(),
                style: context.textThemes.bodyMedium,
              ),
              Consumer(builder: (context, ref, child) {
                return ref.watch(carOwnerProvider).build((carOwner) => Text(
                      ref.watch(cityNameProvider(carOwner?.defaultLocation?.cityId ?? '')).when(
                              data: (cityName) => cityName.translated + ', ',
                              error: ((error, stackTrace) {
                                log('$error');
                                return 'unknowLocation'.translate();
                              }),
                              loading: (() {
                                return '';
                              })) +
                          (carOwner?.defaultLocation?.note ?? ''),
                      style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                    ));
              }),
              SpacingConst.vSpacing16,
              Text(
                'booking.expectedTime'.translate(),
                style: context.textThemes.bodyMedium,
              ),
              Text(
                _controller.durationString,
                style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
              ),
              SpacingConst.vSpacing16,
              Consumer(builder: (context, ref, child) {
                return ref
                    .watch(availableServiceProvider(AvailableServiceData.fromTimeslot(timeslot: orderInfo.timeslot!)))
                    .build((service) => ConditionaryWidget(
                          condition: service.note != null && service.note!.isNotEmpty,
                          trueWidget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                              'booking.serviceNotes'.translate(),
                              style: context.textThemes.bodyMedium,
                            ),
                            Text(
                              service.note ?? '',
                              style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                            ),
                          ]),
                        ));
              }),
            ]),
            decoration: BoxDecoration(
                color: ColorsConst.white,
                borderRadius: BorderRadius.circular(14.sp),
                boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
          ),
          SpacingConst.vSpacing16,
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            width: 330.w,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'booking.paymentMethod'.translate(),
                style: context.textThemes.bodyMedium,
              ),
              CustomDropDown(
                  text: 'paymentMethod.${orderInfo.paymentMethod.name}'.translate(),
                  values: List.generate(
                      paymentMethods.length,
                      (index) => CustomChoice(
                          value: paymentMethods[index],
                          text: 'paymentMethod.${paymentMethods[index].name}'.translate())),
                  onChange: _controller.changePaymentMethod),
              SpacingConst.vSpacing8,
              Row(
                children: [
                  RadioButton(
                    isChecked: orderInfo.useWalletMoney,
                    label: 'booking.useWallet'.translate(),
                    onTap: _controller.toggleUseWalletMoney,
                  ),
                  const Spacer(),
                  Consumer(builder: (context, ref, child) {
                    return ref.watch(walletProvider).when(
                          data: (wallet) => PriceText(
                            price: wallet?.amount ?? 0.0,
                            currency: Currency.sar,
                            currencyColor: ColorsConst.cosmicCobalt,
                          ),
                          loading: () => const LoadingContainer(
                            width: 10,
                            height: 10,
                          ),
                          error: (error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        );
                  })
                ],
              )
            ]),
            decoration: BoxDecoration(
                color: ColorsConst.white,
                borderRadius: BorderRadius.circular(14.sp),
                boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
          ),
          SpacingConst.vSpacing16,
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            width: 330.w,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  'booking.serviceDetails'.translate(),
                  style: context.textThemes.bodyMedium,
                ),
              ),
              SpacingConst.vSpacing8,
              Consumer(builder: (context, ref, child) {
                return ref
                    .watch(servicePriceProvider(AvailableServiceData.fromTimeslot(timeslot: orderInfo.timeslot!)))
                    .when(
                      data: (price) => PriceRow(
                        label: 'booking.serviceType'.translate(),
                        subLabel: orderInfo.selectedService?.name.translated ?? '',
                        price: price.toDouble(),
                      ),
                      error: (error, stackTrace) {
                        log('$error');
                        return const SizedBox.shrink();
                      },
                      loading: () {
                        return LoadingContainer(
                          width: 300.w,
                          height: 30.h,
                        );
                      },
                    );
              }),
              SpacingConst.vSpacing8,
              ConditionaryWidget(
                condition: orderInfo.otherServices != null,
                trueWidget: Consumer(builder: (context, ref, child) {
                  return ref
                      .watch(servicePriceProvider(AvailableServiceData(
                          serviceId: orderInfo.otherServices?.id ?? '',
                          serviceProviderId: orderInfo.timeslot?.serviceProviderId ?? '')))
                      .when(
                    data: (data) {
                      return PriceRow(
                        label: 'booking.otherService'.translate(),
                        subLabel: orderInfo.otherServices?.name.translated ?? '',
                        price: data.toDouble(),
                      );
                    },
                    error: (error, stackTrace) {
                      log('$error');
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return LoadingContainer(
                        width: 300.w,
                        height: 30.h,
                      );
                    },
                  );
                }),
              ),
              SpacingConst.vSpacing8,
              const GarageDivider(),
              SpacingConst.vSpacing8,
              Row(
                children: [
                  Text(
                    'booking.total'.translate(),
                    style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.cosmicCobalt),
                  ),
                  const Spacer(),
                  PriceText(price: orderInfo.totalPrice, currency: Currency.sar)
                ],
              )
            ]),
            decoration: BoxDecoration(
                color: ColorsConst.white,
                borderRadius: BorderRadius.circular(14.sp),
                boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 15)]),
          ),
        ],
        footer: [
          CustomButton(
            icon: GarageIcons.Add,
            onPressed: () async {
              await _controller.onPayPressed(context);
            },
            label: 'payment.pay'.translate(),
            size: ButtonSize.large,
            style: CustomButtonStyle.primary,
          )
        ],
      );
    }));
  }
}

class PriceRow extends StatelessWidget {
  const PriceRow({
    Key? key,
    required this.label,
    required this.price,
    this.subLabel,
  }) : super(key: key);

  final double price;
  final String label;
  final String? subLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: context.textThemes.bodySmall,
        ),
        ConditionaryWidget(
          condition: subLabel != null,
          trueWidget: Text(
            '$subLabel',
            style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
          ),
        ),
        const Spacer(),
        PriceText(
          price: price,
          currency: Currency.sar,
          currencyColor: ColorsConst.cosmicCobalt,
        ),
      ],
    );
  }
}
