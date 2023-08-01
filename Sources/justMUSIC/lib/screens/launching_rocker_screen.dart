import 'package:flutter/Material.dart';
import 'package:justmusic/config/routes.dart';
import 'package:lottie/lottie.dart';

import '../values/constants.dart';

class LaunchingRocketScreen extends StatefulWidget {
  const LaunchingRocketScreen({super.key});

  @override
  State<LaunchingRocketScreen> createState() => _LaunchingRocketScreenState();
}

class _LaunchingRocketScreenState extends State<LaunchingRocketScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  late AnimationController _controller2;
  late Animation<double> _animation;

  @override
  initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 7));

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    final CurvedAnimation curve = CurvedAnimation(parent: _controller2, curve: Curves.easeIn);

    _animation = Tween<double>(
      begin: 0,
      end: 0.6,
    ).animate(curve);

    _controller2.addStatusListener((status) {
      print("cccccccc");
      if (status == AnimationStatus.completed) {
        Navigator.of(context).push(routeRocket());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool animationCompleted = false;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Lottie.asset(
              'assets/animations/rocket.json',
              height: 600,
              frameRate: FrameRate(60),
              fit: BoxFit.contain,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward().whenComplete(() {
                    setState(() {
                      animationCompleted = true;
                    });
                    _controller2.forward();
                  });
              },
            ),
            Center(
                child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double circlePosition = MediaQuery.of(context).size.height * _animation.value;
                return CustomPaint(
                  painter: CirclePainter(circlePosition),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double circlePosition;

  CirclePainter(this.circlePosition);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = bgColor;
    double radius = 50 * circlePosition; // Remplacez par le rayon souhaité de votre cercle
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
