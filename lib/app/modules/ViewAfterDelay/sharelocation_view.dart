import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class ShareLocationViewAnimation extends StatefulWidget {
  const ShareLocationViewAnimation({Key? key}) : super(key: key);

  @override
  _ShareLocationViewAnimationState createState() =>
      _ShareLocationViewAnimationState();
}

class _ShareLocationViewAnimationState extends State<ShareLocationViewAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Sharing Location...',
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: ColorData.colorSos,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 20,
              displayFullTextOnTap: false,
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Your location is being shared with the contacts \nyou have established",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: CirclePainter(animation: _controller),
                  child: const SizedBox(
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  child: Image.asset("assets/images/person1.png"),
                  top: 20,
                  left: 140,
                ),
                Positioned(
                  child: Image.asset("assets/images/person2.png"),
                  top: 80,
                  right: 20,
                ),
                Positioned(
                  child: Image.asset("assets/images/person3.png"),
                  bottom: 80,
                  right: 20,
                ),
                Positioned(
                  child: Image.asset("assets/images/person4.png"),
                  bottom: 20,
                  left: 140,
                ),
                Positioned(
                  child: Image.asset("assets/images/person5.png"),
                  bottom: 80,
                  left: 20,
                ),
                Center(
                  child: Image.asset("assets/images/map-pin.png"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;

  CirclePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.red.withOpacity(0.3);
    final double radius = size.width / 6;

    for (int i = 1; i <= 5; i++) {
      final double rippleRadius = radius * i * animation.value;
      paint.color = Colors.red.withOpacity(0.1 * (6 - i));
      canvas.drawCircle(size.center(Offset.zero), rippleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
