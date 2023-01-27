import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';

class CustomPopupButton extends StatefulWidget {
  const CustomPopupButton(
      {Key? key, required this.items, required this.child, this.maxHeight = 400, this.maxWidth = 300})
      : super(key: key);
  final Widget child;
  final List<Widget> items;
  final double maxWidth;
  final double maxHeight;
  @override
  State<CustomPopupButton> createState() => _CustomPopupButtonState();
}

class _CustomPopupButtonState extends State<CustomPopupButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        elevation: 10,
        offset: const Offset(0, 50),
        padding: EdgeInsets.zero,
        constraints:
            BoxConstraints(maxHeight: widget.maxHeight, maxWidth: widget.maxWidth, minHeight: 10, minWidth: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              height: 100,
              enabled: false,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.items),
            ),
          ];
        },
        child: widget.child);
  }
}

class CustomPopupItem extends StatefulWidget {
  const CustomPopupItem({
    Key? key,
    this.child,
    this.label,
    this.onPressed,
    this.shouldShowHover = true,
    this.shouldCloseOnClick = true,
  })  : assert((child != null && label == null) || (child == null && label != null)),
        super(key: key);

  final String? label;
  final Widget? child;
  final bool shouldCloseOnClick;
  final void Function()? onPressed;
  final bool shouldShowHover;

  @override
  State<CustomPopupItem> createState() => _CustomPopupItemState();
}

class _CustomPopupItemState extends State<CustomPopupItem> {
  Color _color = ColorsConst.white;
  Color _textColor = ColorsConst.dartGrey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: widget.shouldShowHover
          ? widget.shouldShowHover
              ? ((value) {
                  if (value) {
                    setState(() {
                      _color = ColorsConst.cosmicCobalt.withOpacity(0.1);
                      _textColor = ColorsConst.cosmicCobalt;
                    });
                  } else {
                    setState(() {
                      _color = ColorsConst.white;
                      _textColor = ColorsConst.dartGrey;
                    });
                  }
                })
              : null
          : null,
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!();
        if (widget.shouldCloseOnClick) Navigator.of(context).pop();
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 30.sw,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(10)),
        child: widget.label != null
            ? Text(
                widget.label!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: _textColor),
              )
            : widget.child,
      ),
    );
  }
}
