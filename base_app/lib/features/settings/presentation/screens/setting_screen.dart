import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/settings/presentation/controller/settings_controller.dart';
import 'package:garage_client/features/settings/presentation/widgets/setting_item.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/app_version.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final SettingsController _controller;

  @override
  void didChangeDependencies() {
    _controller = SettingsController(context: context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 760.h,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  width: 1.sw,
                  child: Consumer(builder: (context, ref, child) {
                    final carOwener = ref.watch(carOwnerProvider);
                    return carOwener.build((carOwnerData) {
                      return Column(children: [
                        Container(
                          child: Icon(
                            GarageIcons.User,
                            size: 30.sp,
                          ),
                          width: 63.w,
                          height: 63.w,
                          decoration:
                              BoxDecoration(color: ColorsConst.cultured, borderRadius: BorderRadius.circular(63.w)),
                        ),
                        Text(
                          carOwnerData?.name ?? '',
                          style: context.textThemes.bodyLarge?.copyWith(color: ColorsConst.white),
                        ),
                        Text(
                          carOwnerData?.phoneNumber ?? '',
                          textDirection: TextDirection.ltr,
                          style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt.shade100),
                        ),
                      ]);
                    });
                  }),
                  height: 289.h,
                  decoration: BoxDecoration(
                    color: ColorsConst.cosmicCobalt.shade400,
                  )),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: SvgPicture.asset(
                      AssetsConst.logoCorner1,
                      width: 270.w,
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: IgnorePointer(
                    child: SvgPicture.asset(
                      AssetsConst.logoCorner2,
                      width: 220.w,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          SettingItem(
            onTap: _controller.onProfileClick,
            icon: GarageIcons.User,
            text: 'settings.profile'.translate(),
          ),
          SettingItem(
            iconColor: ColorsConst.negativeRed,
            onTap: _controller.onSignOutClick,
            icon: GarageIcons.Logout,
            text: 'settings.signOut'.translate(),
          ),
          const Spacer(),
          Text(
            'settings.version'.translate(arguments: [
              ref
                  .watch(appVersionProvider)
                  .maybeWhen(data: (appVersion) => appVersion.versionAndBuild, orElse: () => '')
            ]),
            style: context.textThemes.displaySmall?.regular,
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
