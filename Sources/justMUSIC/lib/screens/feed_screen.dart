import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/comment_component.dart';
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
  late List<PostComponent> friendFeed;
  late List<PostComponent> discoveryFeed;
  late List<PostComponent> displayFeed;

  @override
  void initState() {
    super.initState();
    friendFeed = [
      PostComponent(
        callback: openDetailPost,
      ),
      PostComponent(
        callback: openDetailPost,
      ),
      PostComponent(
        callback: openDetailPost,
      ),
    ];
    discoveryFeed = [
      PostComponent(callback: openDetailPost),
    ];
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

  void openDetailPost() {
    showModalBottomSheet(
      backgroundColor: bgModal,
      elevation: 1,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: ((context) {
        return Container(
          height: 720.h,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Align(
                child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding, right: defaultPadding),
                    child: SingleChildScrollView(
                      child: Wrap(
                        // to apply margin in the main axis of the wrap
                        runSpacing: 10,
                        children: [
                          PostComponent(
                            callback: null,
                          ),
                          Container(height: 10),
                          Align(
                            child: RichText(
                                text: TextSpan(
                                    text: "3",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                  TextSpan(
                                    text: " commentaires",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  )
                                ])),
                          ),
                          SizedBox(height: 20),
                          CommentComponent(),
                          CommentComponent(),
                          CommentComponent(),
                          Container(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 300),
                height: 70,
                width: double.infinity,
                color: Colors.grey,
                child: TextField(),
              ),
            ],
          ),
        );
      }),
    );
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
            centerOffset: Offset(30.w, -100),
            child: SingleChildScrollView(
              child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: SingleChildScrollView(
                                child: Wrap(
                                  runSpacing: 60,
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
