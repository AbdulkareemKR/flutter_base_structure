import 'package:flutter/material.dart';
import 'package:garage_client/features/login/domain/login_providers.dart';
import 'package:garage_client/features/login/presentation/controllers/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/widgets/otp_text_field/otp_textfield.dart';
import 'package:garage_client/widgets/vector_background_widget.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OtpScreen> createState() => _OtpViewState();
}

class _OtpViewState extends ConsumerState<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(loginScreenControllerProvider.notifier);
    final loginInfo = ref.watch(loginInfoProvider);
    return Sheet(
      children: [
        SizedBox(
          height: 400.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const VectorBackgroundWidget(),
              Positioned(
                top: 90.h,
                child: Column(
                  children: [
                    Text("login.checkOtp".translate(), style: context.textThemes.titleLarge),
                    SpacingConst.vSpacing8,
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        "login.checkYourMessages".translate(arguments: [loginInfo?.phoneNumber?.substring(1) ?? ""]),
                        style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.blackCoral),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SpacingConst.vSpacing70,
                    SizedBox(
                      width: 350.w,
                      child: Form(
                        key: _controller.otpCodeFormKey,
                        child: Focus(
                          onFocusChange: _controller.changeOtpFieldFocus,
                          child: OTPTextField(
                            validator: _controller.otpFieldValidator,
                            fieldsCount: 6,
                            onComplete: _controller.onOtpCheckButtonPressed,
                            key: _controller.otpTextFieldKey,
                          ),
                        ),
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      final isValidOtp = ref.watch(isValidOtpProvider);
                      return Visibility(
                        visible: !isValidOtp,
                        child: Text(
                          "login.incorrectOtp".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.negativeRed),
                        ),
                      );
                    }),
                    SpacingConst.vSpacing6,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing40.w),
                      child: Row(
                        children: [
                          Text(
                            "login.noOtpReached".translate(),
                            style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.dartGrey),
                          ),
                          SpacingConst.hSpacing70,
                          GestureDetector(
                            onTap: _controller.onResendOtpPressed,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final allowResendOtp = ref.watch(allowResendOtpProvider);
                                return Text(
                                  "login.resendOtp".translate(),
                                  style: context.textThemes.caption?.regular.copyWith(
                                      color: allowResendOtp ? ColorsConst.cosmicCobalt : ColorsConst.lightGrey),
                                );
                              },
                            ),
                          ),
                          SpacingConst.hSpacing6,
                          Consumer(
                            builder: (context, ref, child) {
                              final timer = ref.watch(timerToResend);

                              return Text(
                                timer > 0 ? timer.toString() : '',
                                style: context.textThemes.caption?.copyWith(color: ColorsConst.cosmicCobalt),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      footer: [
        Consumer(
          builder: (context, ref, child) {
            final isFocused = ref.watch(isFocusedOtpFieldProvider);
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(bottom: isFocused ? 275.h : 40.h),
              child: CustomButton(
                width: 317.w,
                height: 50.h,
                onPressed: _controller.onOtpCheckButtonPressed,
                label: "check".translate(),
              ),
            );
          },
        )
      ],
    );
  }
}
