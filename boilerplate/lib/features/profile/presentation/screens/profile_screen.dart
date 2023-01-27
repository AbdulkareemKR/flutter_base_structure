import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/profile/presentation/controllers/profile_controller.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_textfield/custom_textfield.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/widgets/custom_textfield/textfield_types.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileStateProvider);
    return state.build((_) {
      final controller = ref.watch(profileStateProvider.notifier);
      return Sheet(
        title: 'settings.profile'.translate(),
        children: [
          CustomTextField(
            type: TextFieldType.normal,
            controller: controller.nameController,
            label: 'settings.name'.translate(),
            width: 288.w,
            height: 38.h,
          ),
          Text(
            'settings.phoneNumber'.translate(),
            style: context.textThemes.bodyMedium?.regular,
          ),
          SpacingConst.vSpacing8,
          Directionality(
            textDirection: TextDirection.ltr,
            child: CustomTextField(
              isEnabled: false,
              type: TextFieldType.normal,
              controller: TextEditingController(text: '+966 | ${controller.userPhoneNumber.replaceAll('+966', '')}'),
              placeHolderText: '+966 | 5XXXXXXXX',
              width: 288.w,
              height: 38.h,
            ),
          ),
        ],
        footer: [
          CustomButton(
            label: 'save'.translate(),
            icon: GarageIcons.User,
            onPressed: () async {
              await controller.onSavePress(context);
            },
          ),
          SpacingConst.vSpacing8,
          CustomButton(
            label: 'settings.deactivateAccount'.translate(),
            icon: GarageIcons.Quit,
            onPressed: () {},
            color: ColorsConst.negativeRed,
          ),
        ],
      );
    });
  }
}
