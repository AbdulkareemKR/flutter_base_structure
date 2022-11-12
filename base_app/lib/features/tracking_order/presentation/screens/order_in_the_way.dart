import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/tracking_order/presentation/widgets/tech_live_direction_map.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class OrderInTheWay extends StatelessWidget {
  const OrderInTheWay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SpacingConst.vSpacing20,
        Container(
          height: 310.h,
          width: 291.w,
          decoration: const BoxDecoration(borderRadius: largeBorderRadius),
          child: const TechLiveDirectionMap(),
        ),
        SpacingConst.vSpacing40,
        Text(
          "orders.service_provider_in_the_way".translate(),
          style: context.textThemes.titleMedium,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
