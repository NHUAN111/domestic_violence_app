import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class SoSViewAnimation extends StatefulWidget {
  const SoSViewAnimation({Key? key}) : super(key: key);

  @override
  _SoSViewAnimationState createState() => _SoSViewAnimationState();
}

class _SoSViewAnimationState extends State<SoSViewAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Please stand by, we are currently requesting for help."
                "Your emergency contacts and nearby rescue services would see your call for help",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 180),
            CustomPaint(
              painter: CirclePainter(animation: _controller),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    "SOS",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double>? animation;

  CirclePainter({this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 4;
    final Paint paint = Paint()..color = ColorData.colorSos.withOpacity(0.3);

    for (int i = 5; i > 0; i--) {
      double rippleRadius = radius * i * animation!.value;
      paint.color = ColorData.colorSos.withOpacity(0.1 * i);
      canvas.drawCircle(size.center(Offset.zero), rippleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
