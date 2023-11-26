import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../components/button_play_component.dart';
import '../components/comment_component.dart';
import '../components/profil_picture_component.dart';
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

  bool isSaved() {
    return MyApp.userViewModel.userCurrent.musicsLikes.contains(widget.post.music.id);
  }

  bool isLiked() {
    return widget.post.likes.contains(MyApp.userViewModel.userCurrent.id);
  }

  @override
  void dispose() {
    MyApp.audioPlayer.release();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  final ScrollController _scrollController = ScrollController();
  String formatPostDate(DateTime postDate) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (postDate.year == now.year && postDate.month == now.month && postDate.day == now.day) {
      // Aujourd'hui
      return "Aujourd'hui, ${postDate.hour}:${postDate.minute.toString().padLeft(2, '0')}";
    } else if (postDate.year == yesterday.year && postDate.month == yesterday.month && postDate.day == yesterday.day) {
      // Hier
      return 'hier, ${postDate.hour}:${postDate.minute.toString().padLeft(2, '0')}';
    } else {
      // Autre date
      return '${postDate.day} ${_getMonthAbbreviation(postDate.month)} ${postDate.hour}:${postDate.minute.toString().padLeft(2, '0')}';
    }
  }


  String _getMonthAbbreviation(int month) {
    const List<String> monthsAbbreviation = [
      'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.',
    ];

    return monthsAbbreviation[month - 1];
  }

// Exemple d'utilisation :
  void main() {
    DateTime postDate = DateTime(2023, 11, 17, 17, 55); // Remplacez par votre date

    String formattedDate = formatPostDate(postDate);
    print(formattedDate); // Affichera "17 nov. 17:55" ou "hier, 17:55" selon la date
  }


  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 0) _scrollController.jumpTo(0);
    });
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
          color: bgAppBar,
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
                                child: PinchZoom(
                                    resetDuration: const Duration(milliseconds: 400),
                                    maxScale: 2.5,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/loadingPlaceholder.gif",
                                      image: choice ? widget.post.selfie! : widget.post.music.cover!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                    height: 200,
                                    margin: EdgeInsets.only(top: 230),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          bgModal.withOpacity(0.5),
                                          bgModal.withOpacity(0.75),
                                          bgModal
                                        ],
                                        stops: [0, 0.2, 0.4, 0.8],
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
                                                  child: ProfilPictureComponent(user: widget.post.user),
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
                                                            ? Text(
                                                          formatPostDate(widget.post.date),
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
                                widget.post.description != null ? Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(50, 35, 50, 35),
                                          color: bgModal,
                                          width: double.infinity,
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
                                        height: 0,
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
                                        padding: EdgeInsets.only(top: 30, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    var bool = await MyApp.postViewModel
                                                        .addOrDeleteFavoritePost(widget.post.id);
                                                    print("testttt");
                                                    if (!bool) {
                                                      widget.post.likes.add(MyApp.userViewModel.userCurrent.id);

                                                      setState(() {});
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text("Vous avez liké cette capsule",
                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                          backgroundColor: primaryColor,
                                                          closeIconColor: Colors.white,
                                                        ),
                                                      );
                                                    } else {
                                                      widget.post.likes.remove(MyApp.userViewModel.userCurrent.id);
                                                      setState(() {});

                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text("Vous avez supprimé votre like",
                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                          backgroundColor: Colors.red,
                                                          closeIconColor: Colors.white,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/images/heart.svg",
                                                    semanticsLabel: 'Like Logo',
                                                    color: isLiked() ? primaryColor : Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 8),
                                                  height: 30,
                                                  child: FutureBuilder<List<String>>(
                                                    future: MyApp.postViewModel.getLikesByPostId(widget.post.id),
                                                    builder:
                                                        (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(snapshot.data!.length.toString(),
                                                            style: GoogleFonts.plusJakartaSans(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w800,
                                                            ));
                                                      } else {
                                                        return Container(
                                                          child: Center(
                                                            child: CupertinoActivityIndicator(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    myFocusNode.requestFocus();
                                                  },
                                                  child: SvgPicture.asset("assets/images/chat.svg",
                                                      semanticsLabel: 'Chat Logo'),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 8),
                                                  height: 30,
                                                  child: FutureBuilder<List<Comment>>(
                                                    future: MyApp.commentViewModel.getCommentsByPostId(widget.post.id),
                                                    builder:
                                                        (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(snapshot.data!.length.toString(),
                                                            style: GoogleFonts.plusJakartaSans(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w800,
                                                            ));
                                                      } else {
                                                        return Container(
                                                          child: Center(
                                                            child: CupertinoActivityIndicator(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            SvgPicture.asset("assets/images/add.svg",
                                                semanticsLabel: 'Add playlist Logo'),
                                            GestureDetector(
                                                onTap: () async {
                                                  var bool = await MyApp.musicViewModel
                                                      .addOrDeleteFavoriteMusic(widget.post.music.id);
                                                  !bool
                                                      ? ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: RichText(
                                                              textAlign: TextAlign.center,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                style: GoogleFonts.plusJakartaSans(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 15,
                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                      text: "${widget.post.music.title}",
                                                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                                                  TextSpan(text: " ajouté à votre collection"),
                                                                ],
                                                              ),
                                                            ),
                                                            backgroundColor: primaryColor,
                                                            closeIconColor: Colors.white,
                                                          ),
                                                        )
                                                      : ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: RichText(
                                                              textAlign: TextAlign.center,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                style: GoogleFonts.plusJakartaSans(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 15,
                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                      text: "${widget.post.music.title}",
                                                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                                                  TextSpan(text: " retiré de votre collection"),
                                                                ],
                                                              ),
                                                            ),
                                                            backgroundColor: Colors.red,
                                                            closeIconColor: Colors.white,
                                                          ),
                                                        );
                                                  setState(() {});
                                                },
                                                child: SvgPicture.asset(
                                                  "assets/images/save.svg",
                                                  semanticsLabel: 'Save Logo',
                                                  color: isSaved() ? primaryColor : Colors.white,
                                                )),
                                            SvgPicture.asset("assets/images/report.svg", semanticsLabel: 'Report Logo'),
                                          ],
                                        ),
                                      ),
                                      FutureBuilder<List<Comment>>(
                                        future: MyApp.commentViewModel.getCommentsByPostId(widget.post.id),
                                        builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              children: [
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
                                            image:
                                                NetworkImage(choice ? widget.post.music.cover! : widget.post.selfie!),
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
                              child: FadeInImage.assetNetwork(
                                image: MyApp.userViewModel.userCurrent.pp,
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                                fadeInDuration: const Duration(milliseconds: 100),
                                placeholder: "assets/images/loadingPlaceholder.gif",
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.text,
                              controller: _textController,
                              focusNode: myFocusNode,
                              onSubmitted: (value) async {
                                if (value.isNotEmpty) {
                                  await MyApp.commentViewModel.addComment(value, widget.post.id, widget.post.user);
                                }
                                setState(() {
                                  _textController.clear();
                                });
                              },
                              onChanged: (value) {
                                setState(() {});
                              },
                              cursorColor: primaryColor,
                              style: GoogleFonts.plusJakartaSans(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: _textController.text.isEmpty
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          if (_textController.text.isNotEmpty) {
                                            await MyApp.commentViewModel
                                                .addComment(_textController.text, widget.post.id, widget.post.user);
                                          }
                                          myFocusNode.unfocus();
                                          setState(() {
                                            _textController.clear();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          color: primaryColor,
                                          size: 20,
                                        )),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: grayText),
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
                                fillColor: bgModal,
                                filled: true,
                                focusColor: Color.fromRGBO(255, 255, 255, 0.30),
                                enabledBorder: const OutlineInputBorder(
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
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
