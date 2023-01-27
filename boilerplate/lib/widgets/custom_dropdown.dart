import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/bottom_sheet/bottom_sheet_navigator.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.text,
    required this.values,
    required this.onChange,
  }) : super(key: key);

  final String text;
  final List<CustomChoice<T>> values;
  final Function(T) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final returnedValue = await showCustomBottomSheet<T>(
            context: context,
            isFullBottomSheet: false,
            child: ChoicesWidget(
              choices: values,
            ));

        if (returnedValue != null) {
          onChange(returnedValue);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        child: Row(children: [
          Text(text,
              style: context.textThemes.bodySmall?.copyWith(
                color: ColorsConst.cosmicCobalt,
              )),
          const Spacer(),
          const Icon(
            GarageIcons.Arrow___Down_2,
            color: ColorsConst.dartGrey,
          )
        ]),
        height: 38.h,
        width: 288.w,
        decoration: BoxDecoration(color: ColorsConst.cultured, borderRadius: BorderRadius.circular(10.sp)),
      ),
    );
  }
}

class ChoicesWidget<T> extends StatelessWidget {
  const ChoicesWidget({
    required this.choices,
    Key? key,
  }) : super(key: key);

  final List<CustomChoice<T>> choices;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(child: Column(children: choices)),
      margin: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.sp)),
      width: 336.w,
    );
  }
}

class CustomChoice<T> extends StatefulWidget {
  const CustomChoice({
    Key? key,
    required this.value,
    required this.text,
  }) : super(key: key);

  final T value;
  final String text;

  @override
  State<CustomChoice<T>> createState() => _CustomChoiceState<T>();
}

class _CustomChoiceState<T> extends State<CustomChoice<T>> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() async {
        HapticFeedback.mediumImpact();
        setState(() {
          _isClicked = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));
        Navigator.of(context).pop(widget.value);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        child: Text(widget.text,
            style: context.textThemes.bodySmall?.copyWith(
              color: ColorsConst.cosmicCobalt,
            )),
        height: 38.h,
        width: 288.w,
        decoration: BoxDecoration(
            color: _isClicked ? ColorsConst.cosmicCobalt.shade100 : ColorsConst.cultured,
            borderRadius: BorderRadius.circular(10.sp)),
      ),
    );
  }
}
