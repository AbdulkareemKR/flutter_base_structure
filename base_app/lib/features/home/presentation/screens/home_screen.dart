import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/assets_const.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/home/domain/providers/active_car_index_provider.dart';
import 'package:garage_client/features/home/presentation/controllers/home_screen_controller.dart';
import 'package:garage_client/features/home/presentation/widgets/active_order_widget.dart';
import 'package:garage_client/features/home/presentation/widgets/car_list_item.dart';
import 'package:garage_client/features/home/presentation/widgets/service_card.dart';
import 'package:garage_client/features/login/presentation/screens/login_screen.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/global_providers/city_name_provider.dart';
import 'package:garage_client/global_providers/orders_provider.dart';
import 'package:garage_client/global_providers/root_services_provider.dart';
import 'package:garage_client/global_providers/user_cars_provider.dart';
import 'package:garage_client/global_providers/wallet_provider.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_size.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/widgets/gard_gesture_detector.dart';
import 'package:garage_client/widgets/selected_indecator.dart';
import 'package:garage_core/enums/currency.dart';
import 'package:garage_core/services/validator.dart';
import 'package:garage_core/widgets/bottom_sheet/bottom_sheet_navigator.dart';
import 'package:garage_core/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_core/widgets/loading_container.dart';
import 'package:garage_core/widgets/price_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.read(homeScreenControllerProvider).pageController.addListener(() {
      ref.read(activeCarIndexProvider.state).state =
          ref.read(homeScreenControllerProvider).pageController.page?.round() ?? 0;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(homeScreenControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GuardGestureDetector(
                onTap: () => _controller.onProfileClick(context),
                child: Container(
                  child: const Icon(
                    GarageIcons.User,
                    color: ColorsConst.cosmicCobalt,
                  ),
                  width: 28.w,
                  height: 28.w,
                  decoration:
                      BoxDecoration(color: ColorsConst.profilePictureGrey, borderRadius: BorderRadius.circular(28.w)),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                return ref.watch(carOwnerProvider).when(
                      data: (carOwner) {
                        return GuardGestureDetector(
                          onTap: () => _controller.onLocationClick(context),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'currentLocation'.translate(),
                                style: context.textThemes.displaySmall?.regular,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                ref.watch(cityNameProvider(carOwner?.defaultLocation?.cityId ?? '')).when(
                                    data: (cityName) => cityName.translated,
                                    error: ((error, stackTrace) => 'choose'.translate()),
                                    loading: () => 'choose'.translate()),
                                style: context.textThemes.bodySmall?.regular.copyWith(color: ColorsConst.cosmicCobalt),
                              ),
                              Icon(
                                GarageIcons.Arrow___Down_2,
                                size: 20.sp,
                                color: ColorsConst.cosmicCobalt,
                              )
                            ],
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                      loading: () => LoadingContainer(
                        width: 50.w,
                        height: 20.h,
                      ),
                    );
              }),
              GuardGestureDetector(
                onTap: _controller.onWalletClick,
                child: Consumer(builder: (context, ref, child) {
                  final userWallet = ref.watch(walletProvider);
                  return userWallet.build(
                    ((data) {
                      return Row(
                        children: [
                          Text(
                            'yourBalance'.translate(),
                            style: context.textThemes.displaySmall?.regular,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          PriceText(
                            fontSize: 15.sp,
                            price: data?.amount ?? 0.0,
                            currency: Currency.sar,
                            currencyColor: ColorsConst.dartGrey,
                          ),
                        ],
                      );
                    }),
                  );
                }),
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Consumer(builder: (context, ref, child) {
              final selectedCarIndex = ref.watch(activeCarIndexProvider);
              final userCars = ref.watch(userCarsProvider);

              return userCars.build((cars) {
                if (Validator.safeListIsNotEmpty(userCars.value)) {
                  ref.read(homeScreenControllerProvider).setDefaultCar(userCars.value?[selectedCarIndex]);
                }

                return SizedBox(
                  width: 1.sw,
                  height: 280.h,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        right: 100.w,
                        top: 0.h,
                        child: Image.asset(AssetsConst.leftTopBackgroundImage),
                      ),
                      Positioned(
                        right: 0,
                        child: Image.asset(AssetsConst.rightBackgroundImage),
                      ),
                      Positioned(
                        right: 230.w,
                        top: 0.h,
                        child: Image.asset(AssetsConst.leftBackgroundImage),
                      ),
                      ConditionaryWidget(
                        condition: cars.isEmpty,
                        trueWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 170.h,
                            ),
                            Text(
                              'noCars'.translate(),
                              style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.blackCoral),
                            ),
                            SpacingConst.vSpacing16,
                            CustomButton(
                              onPressed: () {
                                if (ref.read(carOwnerProvider).asData?.value != null) {
                                  _controller.onAddCarClick(context);
                                } else {
                                  showCustomBottomSheet(context: context, child: const LoginScreen());
                                }
                              },
                              label: 'addCar'.translate(),
                              icon: null,
                              size: ButtonSize.small,
                              style: CustomButtonStyle.primary,
                            )
                          ],
                        ),
                        falseWidget: SizedBox(
                          height: 150.h,
                          child: PageView(
                            controller: _controller.pageController,
                            children: List.generate(
                                cars.length,
                                (index) => CarListItem(
                                      onCarClick: () => _controller.onCarClick(context: context, car: cars[index]),
                                      car: cars[index],
                                    )),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: cars.isNotEmpty,
                          child: Positioned(
                              top: 70.h, child: IgnorePointer(child: Image.asset('assets/images/ellipse1.png')))),
                      Visibility(
                          visible: cars.isNotEmpty,
                          child: Positioned(
                              top: 70.h, child: IgnorePointer(child: Image.asset('assets/images/ellipse2.png')))),
                      Visibility(
                          visible: cars.isNotEmpty,
                          child: Positioned(
                              top: 200.h,
                              child: SelectedIndicator(
                                count: cars.length,
                                selected: selectedCarIndex,
                              ))),
                    ],
                  ),
                );
              });
            }),
            Consumer(builder: (context, ref, child) {
              final carOwner = ref.watch(carOwnerProvider);

              return carOwner.build((carOwnerData) {
                // FIXME: remove this when it is fixed
                // cachedCarOwnerProvider. (AsyncValue.data(carOwnerData));

                return Column(
                  children: [
                    Text(
                      'home.howCanWeHelp'.translate(arguments: [carOwnerData?.name ?? '']),
                      style: context.textThemes.bodyLarge,
                    ),
                    ConditionaryWidget(
                        condition: carOwnerData?.defaultCar == null,
                        trueWidget: Text(
                          'home.priceNote'.translate(),
                          style: context.textThemes.displaySmall?.regular.copyWith(color: ColorsConst.lightGrey),
                        )),
                    SpacingConst.vSpacing20,
                    SizedBox(
                      child: Consumer(builder: (context, ref, child) {
                        final isVisibleOrder = ref.watch(isVisibleOrderProvider);
                        return ref.watch(rootServicesProvider).build((data) => SizedBox(
                              height: isVisibleOrder && carOwnerData != null ? 220.h : null,
                              width: 100.sw,
                              child: GridView.count(
                                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                                shrinkWrap: true,
                                mainAxisSpacing: 20.h,
                                crossAxisSpacing: 20.w,
                                crossAxisCount: 2,
                                childAspectRatio: 1.1,
                                children: List.generate(
                                    data.length,
                                    (index) => ServiceCard(
                                          service: data[index],
                                          onServiceClick: ((service) => _controller.onServiceClick(service, context)),
                                        )),
                              ),
                            ));
                      }),
                    ),
                  ],
                );
              });
            })
          ],
        ),
        bottomSheet: Consumer(builder: (context, ref, child) {
          final activeOrder = ref.watch(activeOrderStream);
          return activeOrder.when(
            data: (order) => order != null ? ActiveOrderWidget(order: order) : const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
          );
        }));
  }
}
