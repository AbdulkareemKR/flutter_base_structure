import 'dart:async';
import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/global_providers/google_maps_provider.dart';
import 'package:garage_client/global_providers/orders_provider.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class TechLiveDirectionMap extends ConsumerStatefulWidget {
  final bool isFullScreen;
  const TechLiveDirectionMap({this.isFullScreen = false, Key? key}) : super(key: key);

  @override
  ConsumerState<TechLiveDirectionMap> createState() => _ServiceProviderDirectionState();
}

class _ServiceProviderDirectionState extends ConsumerState<TechLiveDirectionMap> {
  final Completer<GoogleMapController> _mapController = Completer();

  BitmapDescriptor serviceProviderMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor customerMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    // initializeIcons();
  }

  @override
  Widget build(BuildContext context) {
    final activeOrder = ref.watch(activeOrderProvider);
    final techLiveLocation = ref.watch((techLiveLocationStream(activeOrder!)));

    return techLiveLocation.build(
      (techLiveLocation) {
        final directionResult = ref.watch(directionProvider(activeOrder));
        return techLiveLocation != null
            ? GestureDetector(
                child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          techLiveLocation.location.latitude,
                          techLiveLocation.location.longitude,
                        ),
                        zoom: 14.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("serviceProviderLocation"),
                          position: LatLng(
                            techLiveLocation.location.latitude,
                            techLiveLocation.location.longitude,
                          ),
                          // rotation: LocationData(),
                          visible: true,
                          flat: true,
                          // rotation: ,
                          infoWindow: InfoWindow(
                            title: "location.serviceProviderLocation".translate(),
                          ),
                          icon: ref.watch(serviceProviderMarkerProvider).when(
                              data: (icon) => icon,
                              error: (error, _) => BitmapDescriptor.defaultMarker,
                              loading: () => BitmapDescriptor.defaultMarker),
                          // icon: serviceProviderMarker,
                        ),
                        Marker(
                          markerId: const MarkerId("customerLocation"),
                          position: LatLng(activeOrder.location.latitude, activeOrder.location.longitude),
                          flat: true,
                          infoWindow: InfoWindow(
                            title: 'location.customerLocation'.translate(),
                          ),
                          icon: ref.watch(customerMarkerProvider).when(
                              data: (icon) => icon,
                              error: (error, _) => BitmapDescriptor.defaultMarker,
                              loading: () => BitmapDescriptor.defaultMarker),
                          // icon: customerMarker,
                        ),
                      },
                      polylines: directionResult?.directionPolylines ?? {},
                      mapType: MapType.normal, //map type
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing16.toDouble()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing6.toDouble()),
                              margin: EdgeInsets.all(SpacingConst.spacing6.toDouble()),
                              decoration:
                                  const BoxDecoration(borderRadius: mediumBorderRadius, color: ColorsConst.white),
                              child: Text(
                                "location.timeToArrive".translate(arguments: [directionResult?.duration ?? ""]),
                                style: context.textThemes.caption?.copyWith(color: ColorsConst.dartGrey),
                              ),
                            ),
                            widget.isFullScreen
                                ? GestureDetector(
                                    onTap: () => EasyNavigator.popPage(context),
                                    child: Icon(
                                      GarageIcons.Quit,
                                      size: 25.w,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onDoubleTap: () {
                  EasyNavigator.openPage(
                      context: context,
                      page: const TechLiveDirectionMap(
                        isFullScreen: true,
                      ));
                })
            : Center(
                child: Text(
                "location.locationNotAvailable".translate(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsConst.cosmicCobalt),
              ));
      },
    );
  }
}
