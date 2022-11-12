import 'package:flutter/material.dart';
import 'package:garage_client/features/tracking_order/presentation/controllers/tracking_order_controller.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_core/constants/constants.dart';
import 'package:garage_client/localization/localization.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({
    Key? key,
    required TrackingOrderController viewController,
  })  : _viewController = viewController,
        super(key: key);

  final TrackingOrderController _viewController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: context.textThemes.bodySmall?.regular.copyWith(color: ColorsConst.dartGrey),
      decoration: InputDecoration(
        hintStyle: context.textThemes.bodySmall?.regular.copyWith(color: ColorsConst.lightGrey),
        hintText: "orders.writeYourComment".translate(),
        fillColor: ColorsConst.cultured,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: smallBorderRadius,
          borderSide: BorderSide(color: ColorsConst.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsConst.white),
        ),
        contentPadding: EdgeInsets.all(SpacingConst.spacing6.toDouble()),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 4,
      maxLines: 5,
      onChanged: _viewController.onRatingCommentChange,
    );
  }
}
