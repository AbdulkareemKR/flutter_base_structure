import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/payment/domain/providers/error_provider.dart';
import 'package:garage_client/features/payment/presentation/controllers/card_date_input_formatter.dart';
import 'package:garage_client/features/payment/presentation/controllers/card_number_input_formatter.dart';
import 'package:garage_client/features/payment/presentation/controllers/payment_state_notifier.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_size.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/widgets/custom_textfield/custom_textfield.dart';
import 'package:garage_client/enums/currency.dart';
import 'package:garage_client/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_client/widgets/custom_textfield/textfield_types.dart';
import 'package:garage_client/widgets/loading_container.dart';
import 'package:garage_client/widgets/price_text.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  @override
  void dispose() {
    ref.read(paymentStateProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(paymentStateProvider.notifier);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 38.w),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'payment.payment'.translate(),
              style: context.textThemes.titleMedium,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 11.h),
                width: 305.w,
                height: 99.h,
                child: Column(
                  children: [
                    Text(
                      'payment.price'.translate(),
                      style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.cosmicCobalt.shade300),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return ref.watch(paymentStateProvider).when(
                            data: (paymentData) {
                              return PriceText(
                                fontSize: 25.sp,
                                weight: FontWeight.w500,
                                price: paymentData.amount ?? 0.0,
                                currency: Currency.sar,
                                priceColor: ColorsConst.cosmicCobalt,
                                currencyColor: ColorsConst.cosmicCobalt,
                              );
                            },
                            error: (error, stackTrace) {
                              return const SizedBox.shrink();
                            },
                            loading: (() => LoadingContainer(
                                  width: 50.w,
                                  height: 20.h,
                                )),
                          );
                    }),
                  ],
                ),
                decoration: BoxDecoration(
                    border: ref.watch(errorProvider).isNotEmpty
                        ? Border.all(color: ColorsConst.negativeRed, width: 1.5)
                        : null,
                    borderRadius: BorderRadius.circular(14.sp),
                    boxShadow: [
                      BoxShadow(color: ColorsConst.black.withOpacity(0.08), blurRadius: 10),
                    ],
                    color: ColorsConst.white),
              ),
              ConditionaryWidget(
                condition: ref.watch(errorProvider).isNotEmpty,
                trueWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                  child: Text(
                    ref.watch(errorProvider).translate(),
                    style: context.textThemes.bodyMedium?.medium.copyWith(color: ColorsConst.negativeRed),
                  ),
                ),
              )
            ],
          ),
          SpacingConst.vSpacing16,
          CustomTextField(
            label: 'payment.cardHolderName'.translate(),
            width: 299.w,
            height: 40.h,
            type: TextFieldType.normal,
            controller: _controller.nameController,
            placeHolderText: 'payment.nameGoesHere'.translate(),
          ),
          SpacingConst.vSpacing16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'payment.cardNumber'.translate(),
                style: context.textThemes.bodyMedium?.regular,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomTextField(
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardNumberInputFormatter()
                  ],
                  width: 299.w,
                  height: 40.h,
                  type: TextFieldType.normal,
                  keyboardType: TextInputType.number,
                  controller: _controller.cardNumberController,
                  placeHolderText: '41XX XXXX XXXX XXXX',
                ),
              ),
            ],
          ),
          SpacingConst.vSpacing16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  CardMonthInputFormatter(),
                ],
                label: 'payment.expDate'.translate(),
                width: 137.w,
                height: 40.h,
                type: TextFieldType.normal,
                keyboardType: TextInputType.number,
                controller: _controller.expDateController,
                placeHolderText: 'MM / YY',
              ),
              CustomTextField(
                label: 'payment.cvv'.translate(),
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                width: 137.w,
                height: 40.h,
                type: TextFieldType.normal,
                keyboardType: TextInputType.number,
                controller: _controller.cvvController,
                placeHolderText: 'CVV',
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: CustomButton(
              onPressed: () async {
                await _controller.handlePayPressed(context);
              },
              label: 'payment.pay'.translate(),
              size: ButtonSize.large,
              style: CustomButtonStyle.primary,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      )),
    );
  }
}
