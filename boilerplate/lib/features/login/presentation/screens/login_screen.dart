import 'package:flutter/material.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/login/domain/login_providers.dart';
import 'package:garage_client/features/login/presentation/controllers/login_controller.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_phone_text_field.dart';
import 'package:garage_client/widgets/locale_positioned.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/widgets/vector_background_widget.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(loginScreenControllerProvider.notifier);
    _controller.context = context;
    return Sheet(
      children: [
        SizedBox(
          height: 330.h,
          child: Stack(
            children: [
              const VectorBackgroundWidget(),
              LocalePositioned(
                localeSide: 126.w,
                top: 112.h,
                child: Text("login.welcome".translate(),
                    style: context.textThemes.titleLarge?.copyWith(color: ColorsConst.cosmicCobalt)),
              ),
              LocalePositioned(
                localeSide: 169.w,
                top: 145.h,
                child: Text("login.ourFriend".translate(),
                    style: context.textThemes.titleLarge?.copyWith(
                      color: ColorsConst.pictonBlue.shade400,
                    )),
              ),
            ],
          ),
        ),
        Text("login.loginToServeYou".translate(), style: context.textThemes.bodyMedium),
        SpacingConst.vSpacing20,
        Form(
          key: _controller.phoneNumberFormKey,
          child: CustomPhoneTextField(
            onChange: ref.watch(loginInfoProvider.notifier).updatePhoneNumber,
            validator: _controller.phoneNumberValidator,
          ),
        ),
      ],
      footer: [
        CustomButton(
          width: 317.w,
          height: 50.h,
          onPressed: _controller.onContinuePressed,
          icon: GarageIcons.fast_arrow_right,
          label: 'continue'.translate(),
        ),
      ],
    );
  }
}
