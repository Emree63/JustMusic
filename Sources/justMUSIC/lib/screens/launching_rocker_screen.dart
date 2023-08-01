import 'package:flutter/Material.dart';
import 'package:lottie/lottie.dart';

class LaunchingRocketScreen extends StatefulWidget {
  const LaunchingRocketScreen({super.key});

  @override
  State<LaunchingRocketScreen> createState() => _LaunchingRocketScreenState();
}

class _LaunchingRocketScreenState extends State<LaunchingRocketScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Lottie.asset(
            'assets/animations/rocket.json',
            width: double.infinity,
            frameRate: FrameRate(60),
            fit: BoxFit.contain,
            controller: _controller,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller.forward();
            },
          ),
        ),
      ],
    );
  }
}
