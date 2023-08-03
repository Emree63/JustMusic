import 'dart:async';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late Tuple2<List<Post>, List<Post>> displayFeed;
  bool isDismissed = true;
  bool choiceFeed = true;
  PageController controller = PageController();

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
    _fetchData().then((tuple) {
      friendFeed = tuple.item2;
      displayFeed = tuple.item1;
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    Tuple2<List<Post>, List<Post>> tuple = await _fetchData();
    displayFeed = Tuple2(tuple.item1, tuple.item2);
    setState(() {});
  }

  void changeFeed(bool choice) {
    setState(() {
      if (choice) {
        controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  void openDetailPost(Post post) {
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
            child: DetailPostScreen(post: post));
      }),
    );
  }

  _fetchData() async {
    friendFeed = await MyApp.postViewModel.getPostsFriends();
    discoveryFeed = await MyApp.postViewModel.getBestPosts();
    return Tuple2(friendFeed, discoveryFeed);
  }

  switchTopBar(int index) {
    if (index == 0) {
      setState(() {
        choiceFeed = true;
      });
    } else {
      setState(() {
        choiceFeed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    displayFeed =
        Tuple2(MyApp.postViewModel.postsFriends.reversed.toList(), MyApp.postViewModel.bestPosts.reversed.toList());
    bool empty =
        (choiceFeed == true && displayFeed.item1.isEmpty) || (choiceFeed == false && displayFeed.item2.isEmpty);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              opacity: empty ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: Container(
                decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/images/empty_bg.png"), fit: BoxFit.cover, opacity: 0.3),
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
            ),
            PageView(
              onPageChanged: (value) {
                switchTopBar(value);
              },
              controller: controller,
              scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularRevealAnimation(
                    animation: animation,
                    centerOffset: Offset(30.w, -100),
                    child: Container(
                      height: double.infinity,
                      constraints: BoxConstraints(maxWidth: 600),
                      padding: EdgeInsets.fromLTRB(defaultPadding, 100.h, defaultPadding, 0),
                      child: RefreshIndicator(
                        displacement: 20,
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        onRefresh: _refresh,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          clipBehavior: Clip.none,
                          shrinkWrap: false,
                          itemCount: displayFeed.item1.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child:
                                  PostComponent(callback: openDetailPost, post: displayFeed.item1[index], index: index),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularRevealAnimation(
                    animation: animation,
                    centerOffset: Offset(30.w, -100),
                    child: Container(
                      height: double.infinity,
                      constraints: BoxConstraints(maxWidth: 600),
                      padding: EdgeInsets.fromLTRB(defaultPadding, 100.h, defaultPadding, 0),
                      child: RefreshIndicator(
                        displacement: 20,
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        onRefresh: _refresh,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          clipBehavior: Clip.none,
                          shrinkWrap: false,
                          itemCount: displayFeed.item2.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child:
                                  PostComponent(callback: openDetailPost, post: displayFeed.item2[index], index: index),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                child: TopNavBarComponent(callback: changeFeed, choice: choiceFeed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoEdgeEffectScrollPhysics extends ScrollPhysics {
  const NoEdgeEffectScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  NoEdgeEffectScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return NoEdgeEffectScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Supprimez l'effet de bord (effet de vague)
    return 0.0;
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Supprimez la rétroaction haptique
    return offset;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // Désactivez l'overscroll
    return super.createBallisticSimulation(position, 0.0);
  }
}
