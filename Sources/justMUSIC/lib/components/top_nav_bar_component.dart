import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../config/routes.dart';
import 'package:timezone/timezone.dart' as tz;
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

  bool isDismissed = true;

  final DateTime midnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  void actionSurBouton() async {
    widget.callback(choice);
    await MyApp.postViewModel.getBestPosts();
    await MyApp.postViewModel.getPostsFriends();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> showCapsuleDot() async {
    // Get the timezone for France
    final franceTimeZone = tz.getLocation('Europe/Paris');

    // Get the current date and time in France timezone
    var now = tz.TZDateTime.now(franceTimeZone);

    // Calculate the midnight time for the next day in France timezone
    var midnight = tz.TZDateTime(franceTimeZone, now.year, now.month, now.day + 1);

    bool res = await MyApp.postViewModel.getAvailable();
    if (res) {
      Flushbar(
        maxWidth: 210,
        animationDuration: Duration(seconds: 1),
        forwardAnimationCurve: Curves.easeOutCirc,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        icon: Icon(
          Ionicons.sparkles,
          color: Colors.white,
          size: 18,
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
      ).show(context).then((value) {
        setState(() {
          isDismissed = !isDismissed;
        });
      });
    } else {
      Flushbar(
        maxWidth: 155,
        animationDuration: Duration(seconds: 1),
        forwardAnimationCurve: Curves.easeOutCirc,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        icon: Lottie.asset(
          'assets/animations/LottieHourGlass.json',
          width: 26,
          fit: BoxFit.fill,
        ),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        messageText: Align(
          alignment: Alignment.centerLeft,
          child: CountdownTimer(
            endTime: midnight.millisecondsSinceEpoch,
            textStyle: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 15),
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
        onTap: (_) {},
      ).show(context).then((value) {
        setState(() {
          isDismissed = !isDismissed;
        });
      });
    }
  }

  void checkAvailable() async {
    if (isDismissed) {
      showCapsuleDot();
      setState(() {
        isDismissed = !isDismissed;
      });
    }
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
                onTap: () async {
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
              constraints: BoxConstraints(maxWidth: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ZoomTapAnimation(
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      onTap: () {
                        checkAvailable();
                      },
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
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
                              return Padding(
                                padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 6),
                                child: AutoSizeText(
                                  "Mes amis",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                                ),
                              );
                            } else {
                              return Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 6),
                                  child: AutoSizeText(
                                    "Mes amis",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w300, fontSize: 16, color: unactiveFeed),
                                  ));
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
                              return Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 6),
                                  child: AutoSizeText(
                                    "Discovery",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w300, fontSize: 16, color: unactiveFeed),
                                  ));
                            } else {
                              return Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 6),
                                  child: AutoSizeText(
                                    "Discovery",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                                  ));
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
                onTap: () async {
                  await MyApp.userViewModel.updateUserCurrent();
                  Navigator.of(context).push(routeProfile());
                },
                child: ClipOval(
                  child: SizedBox.fromSize(
                      // Image radius
                      child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loadingPlaceholder.gif',
                    image: MyApp.userViewModel.userCurrent.pp,
                    width: 30,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
