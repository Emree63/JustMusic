import 'dart:async';

import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:text_scroll/text_scroll.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../components/button_play_component.dart';
import '../components/comment_component.dart';

import '../main.dart';
import '../model/Post.dart';
import '../model/Comment.dart';
import '../values/constants.dart';

class DetailPostScreen extends StatefulWidget {
  final Post post;
  const DetailPostScreen({super.key, required this.post});

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  TextEditingController _textController = TextEditingController();
  late FocusNode myFocusNode;
  late StreamSubscription<bool> keyboardSubscription;
  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  bool choice = false;
  DateTime today = DateTime.now();

  void switchChoice() {
    setState(() {
      choice = !choice;
    });
  }

  @override
  void dispose() {
    MyApp.audioPlayer.release();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("post: ${widget.post.date.toString()}");
    print("ajrd: ${DateTime.now().toString()}");
    myFocusNode = FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    super.initState();

    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        myFocusNode.unfocus();
      }
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          resetFullScreen();
        }
      },
      child: Container(
        height: 760.h,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/loadingPlaceholder.gif",
                                image: choice ? widget.post.selfie! : widget.post.music.cover!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 200,
                                margin: EdgeInsets.only(top: 230),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, bgModal],
                                    stops: [0, 0.8],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: choice
                                            ? Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: ClipOval(
                                                  child: SizedBox.fromSize(
                                                    // Image radius
                                                    child: Image(
                                                      image: NetworkImage(widget.post.user.pp),
                                                      width: 45,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : widget.post.music.previewUrl != null
                                                ? ButtonPlayComponent(music: widget.post.music)
                                                : Container(),
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: ScrollConfiguration(
                                                      behavior: ScrollBehavior().copyWith(scrollbars: false),
                                                      child: TextScroll(
                                                        choice ? widget.post.user.pseudo : widget.post.music.title!,
                                                        style: GoogleFonts.plusJakartaSans(
                                                          height: 1,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: 22,
                                                        ),
                                                        mode: TextScrollMode.endless,
                                                        pauseBetween: Duration(milliseconds: 500),
                                                        velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20.0),
                                                    child: choice
                                                        ? DateTime(today.year, today.month, today.day).isAtSameMomentAs(
                                                            DateTime(
                                                              widget.post.date.year,
                                                              widget.post.date.month,
                                                              widget.post.date.day,
                                                            ),
                                                          )
                                                            ? Text(
                                                                "Aujourd'hui, ${widget.post.date.hour}:${widget.post.date.minute}",
                                                                style: GoogleFonts.plusJakartaSans(
                                                                  height: 1,
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w900,
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                            : Text(
                                                                "hier, ${widget.post.date.hour}:${widget.post.date.minute}",
                                                                style: GoogleFonts.plusJakartaSans(
                                                                  height: 1,
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w900,
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                        : Text(
                                                            widget.post.music.date.toString(),
                                                            style: GoogleFonts.plusJakartaSans(
                                                              height: 1,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            choice
                                                ? widget.post.location.item2 != null
                                                    ? Text(
                                                        "${widget.post.location.item1}, ${widget.post.location.item2}",
                                                        style: GoogleFonts.plusJakartaSans(
                                                          color: Colors.white.withOpacity(0.5),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    : Text(
                                                        "",
                                                        style: GoogleFonts.plusJakartaSans(
                                                          color: Colors.white.withOpacity(0.4),
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 13,
                                                        ),
                                                      )
                                                : ScrollConfiguration(
                                                    behavior: ScrollBehavior().copyWith(scrollbars: false),
                                                    child: TextScroll(
                                                      widget.post.music.artists.first.name!,
                                                      style: GoogleFonts.plusJakartaSans(
                                                        height: 1,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 17,
                                                      ),
                                                      mode: TextScrollMode.endless,
                                                      pauseBetween: Duration(milliseconds: 500),
                                                      velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget.post.description != null
                                  ? Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(50, 35, 50, 35),
                                        child: Text(
                                          widget.post.description!,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.plusJakartaSans(
                                            height: 1,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 30,
                                    ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: bgAppBar,
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xFF262626),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset("assets/images/heart.svg", semanticsLabel: 'Like Logo'),
                                          GestureDetector(
                                            onTap: () {
                                              myFocusNode.requestFocus();
                                            },
                                            child:
                                                SvgPicture.asset("assets/images/chat.svg", semanticsLabel: 'Chat Logo'),
                                          ),
                                          SvgPicture.asset("assets/images/add.svg",
                                              semanticsLabel: 'Add playlist Logo'),
                                          SvgPicture.asset("assets/images/save.svg", semanticsLabel: 'Save Logo'),
                                          SvgPicture.asset("assets/images/report.svg", semanticsLabel: 'Report Logo'),
                                        ],
                                      ),
                                    ),
                                    FutureBuilder<List<Comment>>(
                                      future: MyApp.commentViewModel.getCommentsByPostId(widget.post.id),
                                      builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
                                        if (snapshot.hasData) {
                                          print("test:");
                                          return Column(
                                            children: [
                                              snapshot.data!.length > 0
                                                  ? Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: snapshot.data!.length.toString(),
                                                          style: GoogleFonts.plusJakartaSans(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: snapshot.data!.length > 1
                                                                  ? " commentaires"
                                                                  : " commentaire",
                                                              style: GoogleFonts.plusJakartaSans(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              snapshot.data!.length > 0
                                                  ? Padding(
                                                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: snapshot.data?.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return CommentComponent(comment: snapshot.data![index]);
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          );
                                        } else {
                                          return Container(
                                            child: Center(
                                              child: CupertinoActivityIndicator(),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          widget.post.selfie != null
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: ZoomTapAnimation(
                                    onTap: () {
                                      if (widget.post.selfie != null) {
                                        switchChoice();
                                      }
                                    },
                                    enableLongTapRepeatEvent: false,
                                    longTapRepeatDuration: const Duration(milliseconds: 100),
                                    begin: 1.0,
                                    end: 0.96,
                                    beginDuration: const Duration(milliseconds: 70),
                                    endDuration: const Duration(milliseconds: 100),
                                    beginCurve: Curves.decelerate,
                                    endCurve: Curves.easeInOutSine,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(width: 4, color: Colors.white),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        // implementer l'image
                                        child: Image(
                                          image: NetworkImage(choice ? widget.post.music.cover! : widget.post.selfie!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 60,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: grayColor, width: 2)),
                  color: textFieldMessage,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            // Rayon de l'image
                            child: Image.network(
                              MyApp.userViewModel.userCurrent.pp,
                              width: 45,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            keyboardAppearance: Brightness.dark,
                            controller: _textController,
                            focusNode: myFocusNode,
                            onSubmitted: (value) async {
                              if (value.isNotEmpty) {
                                await MyApp.commentViewModel.addComment(value, widget.post.id);
                              }
                              setState(() {
                                _textController.clear();
                              });
                            },
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
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
                              fillColor: bgModal,
                              filled: true,
                              focusColor: Color.fromRGBO(255, 255, 255, 0.30),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: grayText),
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              hintText: 'Ajoutez une réponse...',
                              hintStyle: GoogleFonts.plusJakartaSans(color: grayText),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
