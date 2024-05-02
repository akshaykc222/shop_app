import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';

import '../../data/models/status_model.dart';

class RippleButton extends StatefulWidget {
  final Color? color;
  const RippleButton({super.key, this.color});

  @override
  _RippleButtonState createState() => _RippleButtonState();
}

class _RippleButtonState extends State<RippleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        } else if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CustomPaint(
          painter: MyCustomPainter(_animation.value, color: widget.color),
          child: Container(),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double animationValue;
  final Color? color;
  MyCustomPainter(this.animationValue, {this.color});

  @override
  void paint(Canvas canvas, Size size) {
    for (int value = 1; value >= 0; value--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          value + animationValue,
          color: color);
    }
  }

  void circle(Canvas canvas, Rect rect, double value, {Color? color}) {
    Paint paint = Paint()
      ..color = (color ?? const Color(0xffffa500))
          .withOpacity((1 - (value / 4)).clamp(.0, 1));

    canvas.drawCircle(rect.center,
        sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}

Color? getColor(
  String status,
) {
  OrderStatus sts =
      OrderStatus.values.firstWhere((element) => element.name == status);
  return Colors.red.shade400;
}

Color? getColorFormStatus({StatusModel? model}) {
  if (model != null) {
    String ccw = model.colorCode!.replaceAll("#", "0xFF");
    return Color(int.parse(ccw));
  }
  return null;
}
