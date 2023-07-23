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

class _FeedScreenState extends State<FeedScreen> {
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
    displayFeed = friendFeed;
    super.initState();
  }

  void changeFeed(bool choice) {
    // Mettez ici le code pour l'action que vous souhaitez effectuer avec le paramètre
    if (choice) {
      setState(() {
        displayFeed = friendFeed;
      });
    } else {
      setState(() {
        displayFeed = discoveryFeed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
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
          IgnorePointer(
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topRight, stops: [
                0,
                1
              ], colors: [
                bgColor.withOpacity(1),
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
