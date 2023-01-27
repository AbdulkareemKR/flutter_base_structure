import 'package:flutter/material.dart';
import 'package:garage_client/features/login/presentation/controllers/login_controller.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_textfield/custom_textfield.dart';
import 'package:garage_client/widgets/vector_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/services/easy_navigator.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/widgets/custom_textfield/textfield_types.dart';

class NewUserScreen extends ConsumerStatefulWidget {
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends ConsumerState<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(loginScreenControllerProvider.notifier);
    return Sheet(
      children: [
        SizedBox(
          height: 400.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const VectorBackgroundWidget(),
              Positioned(
                top: 60.h,
                child: Column(
                  children: [
                    Text("login.welcome".translate(),
                        style: context.textThemes.titleLarge?.copyWith(color: ColorsConst.cosmicCobalt)),
                    SpacingConst.vSpacing16,
                    Text("login.tellUsYourName".translate(), style: context.textThemes.bodyMedium),
                    SpacingConst.vSpacing20,
                    CustomTextField(
                      textFieldStyle: context.textThemes.bodySmall!,
                      type: TextFieldType.normal,
                      width: 320.w,
                      height: 40.h,
                      keyboardType: TextInputType.name,
                      controller: _controller.nameController,
                      placeHolderText: "settings.name".translate(),
                    ),
                    SpacingConst.vSpacing60,
                    CustomButton(
                      width: 317.w,
                      height: 50.h,
                      onPressed: () async {
                        await _controller.updateUserName();
                        EasyNavigator.popPage(context);
                      },
                      label: "continue".translate(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
