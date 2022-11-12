import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/widgets/check_box/animated_check.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({
    Key? key,
    this.label,
    required this.onTap,
    this.child,
    this.isChecked = false,
  })  : assert((label != null && child == null) || (child != null && label == null)),
        super(key: key);

  final String? label;
  final void Function() onTap;
  final Widget? child;
  final bool isChecked;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            AnimatedContainer(
              padding: const EdgeInsets.all(3),
              child: widget.isChecked
                  ? const MyPainter(
                      color: Colors.white,
                    )
                  : null,
              duration: const Duration(milliseconds: 150),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: widget.isChecked ? ColorsConst.cosmicCobalt : Colors.transparent,
                  border: widget.isChecked
                      ? null
                      : Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 10,
            ),
            widget.label != null
                ? Text(
                    widget.label!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorsConst.cosmicCobalt),
                  )
                : widget.child!
          ],
        ),
      ),
    );
  }
}
