import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tampay/config/app_colors.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/utils/blur.dart';

class MovingCircles extends StatefulWidget {
  final double height;
  final BorderRadius borderRadius;

  const MovingCircles({super.key, this.height = 800,  this.borderRadius = BorderRadius.zero});

  @override
  _MovingCirclesState createState() => _MovingCirclesState();
}

class _MovingCirclesState extends State<MovingCircles> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Animation<Offset> _animation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _animation1 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(1, 1),
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

    _controller2 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _animation2 = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));

    _controller3 = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
    _animation3 = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 20,
      blurColor: AppColors.kTransparent, colorOpacity: 0.75,
      borderRadius: widget.borderRadius ,
      child: SizedBox(height:   widget.height.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: AnimatedCircle( height:  widget.height.h/5,  animation: _animation1, color: AppColors.kSeaBlue)),
            Expanded(child: AnimatedCircle(  height:  widget.height.h/5,  animation: _animation2, color: AppColors.kPrimary1)),
            Align(
                alignment: Alignment.bottomRight,
                child: AnimatedCircle( height:  widget.height.h/5,  animation: _animation3, color: AppColors.kAmber)),
            // Align(alignment: Alignment.bottomLeft,
            //     child: AnimatedCircle(animation: _animation1, color:  AppColors.kTurquoise, )),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Animation<Offset>>('_animation2', _animation2));
  }
}

class AnimatedCircle extends StatelessWidget {
  final Animation<Offset> animation;
  final Color color;
  final double height;

  const AnimatedCircle({super.key, required this.animation, required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: CustomPaint(
        size: const Size(100, 200),
        painter: CirclePainter(color: color, height: height),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final double height;

  CirclePainter({required this.color, required this.height,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), height.h, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
