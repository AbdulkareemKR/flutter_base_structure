import 'package:flutter/material.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/tracking_order/presentation/controllers/tracking_order_controller.dart';
import 'package:garage_client/features/tracking_order/presentation/widgets/remaining_arrival_time.dart';
import 'package:garage_client/global_providers/google_maps_direction_provider.dart';
import 'package:garage_client/models/order.dart';
import 'package:garage_client/services/easy_navigator.dart';
import 'package:garage_client/services/google_map_direction_services/polyline_result.dart';
import 'package:garage_client/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';

class TechLiveDirectionMap extends ConsumerStatefulWidget {
  final bool isFullScreen;
  final Order order;
  const TechLiveDirectionMap({this.isFullScreen = false, required this.order, Key? key}) : super(key: key);

  @override
  ConsumerState<TechLiveDirectionMap> createState() => _ServiceProviderDirectionState();
}

class _ServiceProviderDirectionState extends ConsumerState<TechLiveDirectionMap> {
  // FIXME: this is just a temp solution for saving the previous value of the location data while the new data is loading
  PolylineResult? previousLocation;

  late final TrackingOrderController _controller = TrackingOrderController(context: context, ref: ref);

  @override
  Widget build(BuildContext context) {
    final directionResult = ref.watch(directionProvider(widget.order.id!));

    return Container();
  }
}
