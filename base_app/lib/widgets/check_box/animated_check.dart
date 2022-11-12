//Add this CustomPaint widget to the Widget Tree
import 'package:flutter/material.dart';
import 'package:garage_client/widgets/check_box/check_custom_paint.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({Key? key, required this.color, this.duration = const Duration(milliseconds: 150)}) : super(key: key);

  @override
  _MyPainterState createState() => _MyPainterState();

  final Duration duration;
  final Color color;
}

class _MyPainterState extends State<MyPainter> with TickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  late AnimationController controller;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    controller2 = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Tween<double> _animationTween = Tween(begin: 0, end: 0.3526907);
    Tween<double> _animationTween2 = Tween(begin: 0, end: 0.8825755);
    Tween<double> _animationTween3 = Tween(begin: 0.3526907, end: 0.9332467);
    Tween<double> _animationTween4 = Tween(begin: 0.8825755, end: 0.09090909);

    animation = _animationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (controller.isCompleted) {
          controller2.forward();
        }
      });

    animation2 = _animationTween2.animate(controller)
      ..addListener(() {
        setState(() {});
      });

    animation3 = _animationTween3.animate(controller2)
      ..addListener(() {
        setState(() {});
      });
    animation4 = _animationTween4.animate(controller2)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) {
        return CustomPaint(
          size: Size(
              10,
              (10 * 1)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: CheckCustomPaint(
              value1: animation.value,
              value2: animation2.value,
              value3: animation3.value,
              value4: animation4.value,
              color: widget.color),
        );
      },
    );
  }
}
