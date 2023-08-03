import 'dart:async';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';
import 'package:justmusic/main.dart';
import 'package:tuple/tuple.dart';
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
  Timer? timer;

  late List<Post> discoveryFeed;
  late List<Post> displayFeed;
  bool isDismissed = true;
  bool choiceFeed = false;

  @override
  void initState() {
    super.initState();
    friendFeed = MyApp.postViewModel.postsFriends;
    discoveryFeed = MyApp.postViewModel.bestPosts;
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
    if (choiceFeed) {
      await MyApp.postViewModel.getBestPosts();
      setState(() {});
    } else {
      await MyApp.postViewModel.getPostsFriends();
      setState(() {});
    }
  }

  void changeFeed(bool choice) {
    // Mettez ici le code pour l'action que vous souhaitez effectuer avec le paramètre
    if (choice) {
      setState(() {
        animationController.reset();
        displayFeed = MyApp.postViewModel.postsFriends.reversed.toList();
        animationController.forward();
        choiceFeed = false;
      });
    } else {
      setState(() {
        animationController.reset();
        displayFeed = MyApp.postViewModel.bestPosts.reversed.toList();
        animationController.forward();
        choiceFeed = true;
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

  _fetchData() async {
    friendFeed = await MyApp.postViewModel.getPostsFriends();
    discoveryFeed = await MyApp.postViewModel.getBestPosts();
    return Tuple2(friendFeed, displayFeed);
  }

  @override
  Widget build(BuildContext context) {
    if (choiceFeed) {
      displayFeed = MyApp.postViewModel.postsFriends.reversed.toList();
    } else {
      displayFeed = MyApp.postViewModel.bestPosts.reversed.toList();
    }
    _fetchData();

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
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircularRevealAnimation(
                          animation: animation,
                          centerOffset: Offset(30.w, -100),
                          child: Expanded(
                            child: Container(
                                height: double.infinity,
                                constraints: BoxConstraints(maxWidth: 600),
                                padding: EdgeInsets.fromLTRB(defaultPadding, 100.h, defaultPadding, 0),
                                child: Expanded(
                                  child: FutureBuilder(
                                    future: _fetchData(),
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        return RefreshIndicator(
                                          displacement: 20,
                                          triggerMode: RefreshIndicatorTriggerMode.onEdge,
                                          onRefresh: _refresh,
                                          child: Expanded(
                                            child: ListView.builder(
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              clipBehavior: Clip.none,
                                              shrinkWrap: true,
                                              itemCount: displayFeed.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 40),
                                                  child: PostComponent(
                                                      callback: openDetailPost, post: displayFeed[index], index: index),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CupertinoActivityIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                )),
                          ),
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
              ));
  }
}
