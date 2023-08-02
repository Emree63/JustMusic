import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';

import '../components/post_component.dart';
import '../components/top_nav_bar_component.dart';
import '../model/Post.dart';
import '../values/constants.dart';
import 'detail_post_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late List<Post> friendFeed;
  late List<Post> discoveryFeed;
  late List<Post> displayFeed;

  @override
  void initState() {
    super.initState();
    MyApp.postViewModel.getPostsFriends();
    friendFeed = MyApp.postViewModel.postsFriends;
    MyApp.postViewModel.getBestPosts();
    discoveryFeed = MyApp.postViewModel.bestPosts;
    displayFeed = [];
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

  Future _refresh() async {
    print("refresh");
    discoveryFeed = await MyApp.postViewModel.getBestPosts();
    setState(() {
      displayFeed = discoveryFeed.reversed.toList();
    });
  }

  void changeFeed(bool choice) {
    // Mettez ici le code pour l'action que vous souhaitez effectuer avec le paramètre
    if (choice) {
      setState(() {
        animationController.reset();
        displayFeed = MyApp.postViewModel.postsFriends.reversed.toList();
        animationController.forward();
        print(displayFeed.length);
      });
    } else {
      setState(() {
        animationController.reset();
        displayFeed = MyApp.postViewModel.bestPosts.reversed.toList();
        print(displayFeed.length);
        animationController.forward();
      });
    }
  }

  void openDetailPost(int index) {
    showModalBottomSheet(
      backgroundColor: bgModal,
      elevation: 1,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: ((BuildContext context) {
        return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: DetailPostScreen(post: displayFeed[index]));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        body: displayFeed.isEmpty
            ? Container(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/empty_bg.png"), fit: BoxFit.cover, opacity: 0.3),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 140.h, left: defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Suis tes amis pour voir leurs capsules",
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white, fontSize: 23, fontWeight: FontWeight.w800))
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: IgnorePointer(
                        child: Container(
                          height: 240.h,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  stops: [0.3, 1],
                                  colors: [bgColor.withOpacity(0.9), bgColor.withOpacity(0)])),
                        ),
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
              )
            : Container(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircularRevealAnimation(
                        animation: animation,
                        centerOffset: Offset(30.w, -100),
                        child: Container(
                            constraints: BoxConstraints(maxWidth: 600),
                            padding: EdgeInsets.fromLTRB(defaultPadding, 100.h, defaultPadding, 0),
                            child: RefreshIndicator(
                              displacement: 20,
                              triggerMode: RefreshIndicatorTriggerMode.onEdge,
                              onRefresh: _refresh,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                                clipBehavior: Clip.none,
                                shrinkWrap: true,
                                itemCount: displayFeed.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child:
                                        PostComponent(callback: openDetailPost, post: displayFeed[index], index: index),
                                  );
                                },
                              ),
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: IgnorePointer(
                        child: Container(
                          height: 240.h,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  stops: [0.3, 1],
                                  colors: [bgColor.withOpacity(0.9), bgColor.withOpacity(0)])),
                        ),
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
              ));
  }
}
