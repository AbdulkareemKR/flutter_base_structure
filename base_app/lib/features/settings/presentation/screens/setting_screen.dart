import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/settings/presentation/controller/settings_controller.dart';
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
                        SpacingConst.vSpacing20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SettingBox(
                              onTap: _controller.onOrdersClick,
                              icon: GarageIcons.Cart,
                              text: 'settings.orders'.translate(),
                            ),
                            SettingBox(
                              onTap: _controller.onWalletClick,
                              icon: GarageIcons.Wallet,
                              text: 'settings.wallet'.translate(),
                            ),
                            SettingBox(
                              onTap: _controller.onCarsClick,
                              icon: GarageIcons.Car,
                              text: 'settings.myCars'.translate(),
                            )
                          ],
                        )
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

          ///TODO: uncomment when ready
          // SettingItem(
          //   onTap: _controller.onGiftClick,
          //   icon: GarageIcons.Gift,
          //   text: 'settings.gifts'.translate(),
          // ),

          ///TODO: uncomment when ready
          // SettingItem(
          //   onTap: _controller.onCouponsClick,
          //   icon: GarageIcons.Ticket,
          //   text: 'settings.coupons'.translate(),
          // ),

          ///TODO: uncomment when ready
          // SettingItem(
          //   onTap: _controller.onHelpClick,
          //   icon: GarageIcons.Info_Square,
          //   text: 'settings.help'.translate(),
          // ),
          SettingItem(
            onTap: _controller.onTermsClick,
            icon: GarageIcons.Document,
            text: 'settings.terms'.translate(),
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

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconColor = ColorsConst.cosmicCobalt,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final void Function() onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        HapticFeedback.mediumImpact();
        onTap();
      }),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 7.w),
        child: Row(children: [
          SpacingConst.hSpacing8,
          Container(
            child: Icon(
              icon,
              size: 15.sp,
              color: iconColor,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.sp),
              color: ColorsConst.cultured,
            ),
            width: 30.w,
            height: 30.w,
          ),
          SpacingConst.hSpacing16,
          Text(
            text,
            style: context.textThemes.bodySmall,
          )
        ]),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        width: 311.w,
        height: 48.h,
        decoration: BoxDecoration(
            color: ColorsConst.white,
            boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.08), blurRadius: 10)],
            borderRadius: BorderRadius.circular(14.sp)),
      ),
    );
  }
}

class SettingBox extends StatelessWidget {
  const SettingBox({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        HapticFeedback.mediumImpact();
        onTap();
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.19.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30.r,
                width: 30.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusConst.smallBorderRadius,
                  color: ColorsConst.cultured,
                ),
                child: Icon(
                  icon,
                  color: ColorsConst.cosmicCobalt,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(text)
            ]),
        width: 109.w,
        height: 88.h,
        decoration: BoxDecoration(color: ColorsConst.white, borderRadius: BorderRadius.circular(13.sp)),
      ),
    );
  }
}
