import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/post_component.dart';
import '../components/top_nav_bar_component.dart';
import '../values/constants.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  List<PostComponent> friendFeed = [
    PostComponent(),
    PostComponent(),
    PostComponent(),
  ];
  List<PostComponent> discoveryFeed = [
    PostComponent(),
  ];
  late List<PostComponent> displayFeed;

  @override
  void initState() {
    super.initState();
    displayFeed = friendFeed;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutSine,
    );
    animationController.forward();
  }

  void changeFeed(bool choice) {
    // Mettez ici le code pour l'action que vous souhaitez effectuer avec le paramètre
    if (choice) {
      setState(() {
        animationController.reset();
        displayFeed = friendFeed;
        animationController.forward();
      });
    } else {
      setState(() {
        animationController.reset();
        displayFeed = discoveryFeed;
        animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CircularRevealAnimation(
            animation: animation,
//                centerAlignment: Alignment.centerRight,
            centerOffset: Offset(70, 0),
            child: SingleChildScrollView(
              child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: displayFeed,
                                ),
                              )),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          IgnorePointer(
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topRight, stops: [
                0.3,
                1
              ], colors: [
                bgColor.withOpacity(0.9),
                bgColor.withOpacity(0)
              ])),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: TopNavBarComponent(callback: changeFeed),
            ),
          ),
        ],
      ),
    );
  }
}
