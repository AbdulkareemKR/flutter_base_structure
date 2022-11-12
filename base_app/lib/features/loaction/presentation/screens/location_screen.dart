import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/loaction/presentation/controllers/location_notifier.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/global_providers/city_name_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_popup.dart';
import 'package:garage_client/widgets/custom_textfield/custom_textfield.dart';
import 'package:garage_client/widgets/radio_button/radio_button.dart';
import 'package:garage_core/services/easy_navigator.dart';
import 'package:garage_core/utilis/logger/extensions.dart';
import 'package:garage_core/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_core/widgets/custom_textfield/textfield_types.dart';
import 'package:garage_core/widgets/loading_container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(locationStateProvider);
    final _controller = ref.watch(locationStateProvider.notifier);

    final carOwner = ref.watch(carOwnerProvider);

    return carOwner.build(((carOwnerInfo) {
      return Scaffold(
        body: Stack(alignment: AlignmentDirectional.center, children: [
          GoogleMap(
            onCameraIdle: () async => _controller.updateCurrentLocation(),
            scrollGesturesEnabled: _controller.canDragMap,
            myLocationButtonEnabled: state.isBeingEditedLocation == true ? true : false,
            myLocationEnabled: true,
            mapType: MapType.normal,
            padding: SpacingConst.mapPadding,
            initialCameraPosition: CameraPosition(
                zoom: 15,
                target: LatLng(carOwnerInfo?.defaultLocation?.latitude ?? 26.334082,
                    carOwnerInfo?.defaultLocation?.longitude ?? 50.191345)),
            onMapCreated: (GoogleMapController controller) {
              _controller.mapController = controller;
            },
          ),
          Positioned(
              top: 50.h,
              left: 30.w,
              child: GestureDetector(
                onTap: (() {
                  EasyNavigator.popPage(context);
                }),
                child: Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(color: ColorsConst.white, borderRadius: BorderRadius.circular((30.w))),
                    child: const Icon(Icons.close)),
              )),
          Padding(
            padding: SpacingConst.mapPadding,
            child: SvgPicture.asset(AssetsConst.locationMarker),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 12.h),
                child: ConditionaryWidget(
                  condition: state.isBeingEditedLocation != true,
                  trueWidget: ConditionaryWidget(
                    condition: carOwnerInfo!.locations.isNotEmpty,
                    falseWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('location.noLocations'.translate()),
                        SpacingConst.vSpacing20,
                        CustomButton(
                            label: 'location.addNewLocation'.translate(),
                            icon: null,
                            onPressed: () async {
                              await _controller.onAddNewLocation(context);
                            }),
                      ],
                    ),
                    trueWidget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text(
                        'location.carsLocation'.translate(),
                        style: context.textThemes.bodyLarge,
                      ),
                      SpacingConst.vSpacing16,
                      SizedBox(
                        height: 100.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              carOwnerInfo.locations.length,
                              (index) {
                                return Row(
                                  children: [
                                    RadioButton(
                                      isChecked: carOwnerInfo.locations[index] == carOwnerInfo.defaultLocation,
                                      onTap: () {
                                        if (carOwnerInfo.locations[index] != carOwnerInfo.defaultLocation) {
                                          _controller.changeDefaultLocation(
                                              carOwnerInfo.locations[index], carOwnerInfo.uid);
                                        }
                                      },
                                      child: Text(
                                        ref.watch(cityNameProvider(carOwnerInfo.locations[index].cityId)).when(
                                              data: (data) =>
                                                  '${data.translated}, ${carOwnerInfo.locations[index].note!}',
                                              error: (error, stackTrace) {
                                                error.logException();
                                                return '';
                                              },
                                              loading: () => '',
                                            ),
                                        style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                                      ),
                                    ),
                                    const Spacer(),
                                    CustomPopupButton(
                                      maxWidth: 119.w,
                                      items: [
                                        CustomPopupItem(
                                          child: Text(
                                            "edit".translate(),
                                            style: context.textThemes.bodySmall,
                                          ),
                                          onPressed: (() {
                                            _controller.changeBeingEditedLocation(carOwnerInfo.locations[index]);
                                          }),
                                        ),
                                        CustomPopupItem(
                                          child: Text(
                                            "delete".translate(),
                                            style: context.textThemes.bodySmall,
                                          ),
                                          onPressed: (() {
                                            _controller.onDeletePressed(
                                                carOwnerInfo.locations[index], carOwnerInfo.uid);
                                          }),
                                        )
                                      ],
                                      child: const Icon(
                                        Icons.more_vert_rounded,
                                        color: ColorsConst.blackCoral,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                          label: 'location.addNewLocation'.translate(),
                          icon: null,
                          onPressed: () async {
                            await _controller.onAddNewLocation(context);
                          }),
                      SpacingConst.vSpacing8,
                    ]),
                  ),
                  falseWidget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      'location.carsLocation'.translate(),
                      style: context.textThemes.bodyLarge,
                    ),
                    SpacingConst.vSpacing16,
                    Consumer(builder: (context, ref, child) {
                      final locationInfo = ref.watch(locationGeocodingStateProvider);
                      return locationInfo != null
                          ? Text(
                              "${locationInfo.city ?? "unknown".translate()}, ${locationInfo.country ?? "unknown".translate()}",
                              style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.cosmicCobalt),
                            )
                          : LoadingContainer(
                              width: 100.w,
                              height: 26.h,
                            );
                    }),
                    SpacingConst.vSpacing8,
                    CustomTextField(
                      type: TextFieldType.normal,
                      controller: _controller.noteController,
                      width: 300.w,
                      height: 40.h,
                      placeHolderText: 'location.locationNote'.translate(),
                    ),
                    const Spacer(),
                    Center(
                      child: CustomButton(
                        label: 'save'.translate(),
                        onPressed: () async {
                          await _controller.onLocationSavePress(context: context, uid: carOwnerInfo.uid);
                        },
                        icon: null,
                      ),
                    ),
                    SpacingConst.vSpacing8,
                  ]),
                ),
                width: 375.w,
                constraints: BoxConstraints(maxHeight: 250.h, maxWidth: 375.w),
                decoration: BoxDecoration(
                    color: ColorsConst.white,
                    borderRadius: BorderRadiusConst.largeBorderRadius
                        .copyWith(bottomLeft: Radius.zero, bottomRight: Radius.zero)),
              )),
        ]),
      );
    }));
  }
}
