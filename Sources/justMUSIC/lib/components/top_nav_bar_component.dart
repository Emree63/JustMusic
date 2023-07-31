import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../config/routes.dart';
import '../main.dart';
import '../values/constants.dart';

class TopNavBarComponent extends StatefulWidget {
  final Function(bool) callback;
  const TopNavBarComponent({Key? key, required this.callback}) : super(key: key);

  @override
  State<TopNavBarComponent> createState() => _TopNavBarComponentState();
}

class _TopNavBarComponentState extends State<TopNavBarComponent> with TickerProviderStateMixin {
  bool choice = true;
  late AnimationController _controller;

  void actionSurBouton() {
    widget.callback(choice);
    MyApp.postViewModel.getBestPosts();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    super.initState();
  }

  void showCapsuleDot() {
    Flushbar(
      maxWidth: 210,
      animationDuration: Duration(seconds: 1),
      forwardAnimationCurve: Curves.easeOutCirc,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      icon: Icon(
        Ionicons.sparkles,
        color: Colors.grey,
        size: 22,
      ),
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      messageText: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Capsule disponible",
          style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 15),
        ),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      textDirection: Directionality.of(context),
      borderRadius: BorderRadius.circular(1000),
      borderWidth: 1,
      borderColor: Colors.white.withOpacity(0.04),
      duration: const Duration(minutes: 100),
      leftBarIndicatorColor: Colors.transparent,
      positionOffset: 20,
      onTap: (_) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/post');
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context).push(routeAddFriend());
                },
                child: const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 170),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ZoomTapAnimation(
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      onTap: showCapsuleDot,
                      end: 0.97,
                      beginDuration: const Duration(milliseconds: 70),
                      endDuration: const Duration(milliseconds: 100),
                      beginCurve: Curves.decelerate,
                      endCurve: Curves.easeInOutSine,
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                        height: 30,
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!choice) {
                            setState(() {
                              choice = !choice;
                              actionSurBouton();
                            });
                          }
                        },
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            if (choice) {
                              return AutoSizeText(
                                "Mes amis",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                              );
                            } else {
                              return AutoSizeText(
                                "Mes amis",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w300, fontSize: 16, color: unactiveFeed),
                              );
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (choice) {
                            setState(() {
                              choice = !choice;
                              actionSurBouton();
                            });
                          }
                        },
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            if (choice) {
                              return AutoSizeText(
                                "Discovery",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w300, fontSize: 16, color: unactiveFeed),
                              );
                            } else {
                              return AutoSizeText(
                                "Discovery",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(routeProfile());
                },
                child: ClipOval(
                  child: SizedBox.fromSize(
                    // Image radius
                    child: Image(
                      image: NetworkImage(MyApp.userViewModel.userCurrent.pp),
                      width: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
