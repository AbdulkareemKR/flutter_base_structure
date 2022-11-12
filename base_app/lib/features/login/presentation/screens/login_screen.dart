import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/login/presentation/controllers/login_screen_controller.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_textfield/custom_textfield.dart';

import 'package:garage_client/global_services/widgets/custom_textfield/textfield_types.dart';

import 'package:garage_client/widgets/locale_positioned.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/widgets/vector_background_widget.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/features/login/presentation/controllers/login_screen_controller.dart';
import 'package:garage_client/localization/extensions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final LoginScreenController _controller;
  @override
  void didChangeDependencies() {
    _controller = LoginScreenController(context: context, ref: ref);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
        CustomTextField(
          label: "email".translate(),
          type: TextFieldType.normal,
          controller: _controller.emailController,
          width: 300.w,
          height: 50.h,
          placeHolderText: "example@Garage.com",
        ),
        SpacingConst.vSpacing16,
        CustomTextField(
          isPassword: true,
          label: "password".translate(),
          type: TextFieldType.normal,
          controller: _controller.passwordController,
          width: 300.w,
          height: 50.h,
          placeHolderText: "*********",
        )
      ],
      footer: [
        CustomButton(
          width: 317.w,
          height: 50.h,
          onPressed: _controller.onLoginPressed,
          label: 'loginButton'.translate(),
        ),
      ],
    );
  }
}
