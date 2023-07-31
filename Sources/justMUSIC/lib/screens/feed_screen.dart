import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';
import '../components/comment_component.dart';
import '../components/post_component.dart';
import '../components/top_nav_bar_component.dart';
import '../model/Post.dart';
import '../values/constants.dart';

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

  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  void changeFeed(bool choice) {
    // Mettez ici le code pour l'action que vous souhaitez effectuer avec le paramètre
    if (choice) {
      setState(() {
        animationController.reset();
        displayFeed = MyApp.postViewModel.postsFriends;
        animationController.forward();
        print(displayFeed.length);
      });
    } else {
      setState(() {
        animationController.reset();
        displayFeed = MyApp.postViewModel.bestPosts;
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
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              resetFullScreen();
            }
          },
          child: Container(
            height: 720.h,
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Align(
                  child: Container(
                      width: 60,
                      height: 5,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                        child: Wrap(
                          // to apply margin in the main axis of the wrap
                          runSpacing: 10,
                          children: [
                            PostComponent(
                              callback: null,
                              post: displayFeed[index],
                              index: index,
                            ),
                            Container(height: 5),
                            Text('${displayFeed[index].description ?? ""}',
                                style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w200)),
                            Container(height: 20),
                            Align(
                              child: RichText(
                                  text: TextSpan(
                                      text: "3",
                                      style:
                                          GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                                      children: [
                                    TextSpan(
                                      text: " commentaires",
                                      style:
                                          GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w300),
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
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: grayColor, width: 2)), color: textFieldMessage),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  // Image radius
                                  child: const Image(
                                    image: AssetImage("assets/images/exemple_profile.png"),
                                    width: 45,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardAppearance: Brightness.dark,
                                  cursorColor: primaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.send,
                                        color: grayText,
                                        size: 20,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: grayText),
                                          borderRadius: BorderRadius.all(Radius.circular(100))),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
                                      fillColor: bgModal,
                                      filled: true,
                                      focusColor: Color.fromRGBO(255, 255, 255, 0.30),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: grayText),
                                          borderRadius: BorderRadius.all(Radius.circular(100))),
                                      hintText: 'Ajoutez une réponse...',
                                      hintStyle: GoogleFonts.plusJakartaSans(color: grayText)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              child: CircularRevealAnimation(
                animation: animation,
                centerOffset: Offset(30.w, -100),
                child: Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.fromLTRB(defaultPadding, 100.h, defaultPadding, 0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemCount: displayFeed.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: PostComponent(callback: openDetailPost, post: displayFeed[index], index: index),
                        );
                      },
                    )),
              ),
            ),
            IgnorePointer(
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        stops: [0.3, 1],
                        colors: [bgColor.withOpacity(0.9), bgColor.withOpacity(0)])),
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
      ),
    );
  }
}
