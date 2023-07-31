import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../model/Post.dart';

class PostComponent extends StatefulWidget {
  final Function(int)? callback;
  final Post post;
  final int index;

  PostComponent({Key? key, required this.callback, required this.post, required this.index}) : super(key: key);

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  bool choice = false;
  DateTime today = DateTime.now();

  void switchChoice() {
    setState(() {
      choice = !choice;
    });
  }

  @override
  void initState() {
    print("post: ${widget.post.date.toString()}");
    print("ajrd: ${DateTime.now().toString()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: switchChoice,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (widget.callback == null) {
            return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            // Image radius
                            child: Image(
                              image: NetworkImage(widget.post.user.pp),
                              width: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post.user.pseudo,
                                  style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                widget.post.location.item2 != null
                                    ? Text(
                                        "${widget.post.location.item1}, ${widget.post.location.item2}",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white.withOpacity(0.4),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13),
                                      )
                                    : Text(
                                        "",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white.withOpacity(0.4),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13),
                                      )
                              ],
                            ),
                          ),
                        ),
                        DateTime(today.year, today.month, today.day).isAtSameMomentAs(
                                DateTime(widget.post.date.year, widget.post.date.month, widget.post.date.day))
                            ? Text(
                                "Aujourd'hui, ${widget.post.date.hour}:${widget.post.date.minute}",
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 13),
                              )
                            : Text(
                                "${widget.post.date.day}/${widget.post.date.month}/${widget.post.date.year}-${widget.post.date.hour}:${widget.post.date.minute}",
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 13),
                              ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ZoomTapAnimation(
                        onTap: () {
                          if (widget.post.selfie != null) {
                            switchChoice();
                          }
                        },
                        enableLongTapRepeatEvent: false,
                        longTapRepeatDuration: const Duration(milliseconds: 100),
                        begin: 1.0,
                        end: 0.99,
                        beginDuration: const Duration(milliseconds: 70),
                        endDuration: const Duration(milliseconds: 100),
                        beginCurve: Curves.decelerate,
                        endCurve: Curves.easeInOutSine,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            decoration: BoxDecoration(
                              // add border
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  Colors.transparent,
                                  Color(0xFF323232),
                                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                width: 2.5,
                              ),
                              // set border radius
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              // implement image
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image(
                                    image: NetworkImage(choice ? widget.post.selfie! : widget.post.music.cover!),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  widget.post.selfie != null
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 140, maxHeight: 140),
                                              width: 90.sp,
                                              height: 90.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                // add border
                                                border: Border.all(width: 3, color: Colors.white),
                                                // set border radius
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(13),
                                                // implement image
                                                child: Image(
                                                  image: NetworkImage(
                                                      choice ? widget.post.music.cover! : widget.post.selfie!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 8,
                            child: TextScroll(
                              widget.post.music.artists.first.name!,
                              style: GoogleFonts.plusJakartaSans(
                                  height: 1, color: Colors.white, fontWeight: FontWeight.w600, fontSize: 26.h),
                              mode: TextScrollMode.endless,
                              pauseBetween: Duration(milliseconds: 500),
                              velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                            )),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h, right: 5.w, left: 5.w),
                          child: ClipOval(
                            child: Container(
                              width: 5.h,
                              height: 5.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 8,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: TextScroll(
                                widget.post.music.title!,
                                style: GoogleFonts.plusJakartaSans(
                                    height: 1, color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.h),
                                mode: TextScrollMode.endless,
                                velocity: Velocity(pixelsPerSecond: Offset(50, 20)),
                                pauseBetween: Duration(milliseconds: 500),
                              ),
                            )),
                        Container(width: 10),
                        AutoSizeText(
                          widget.post.music.date.toString(),
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w300, fontSize: 16.h),
                          textAlign: TextAlign.end,
                          maxFontSize: 20,
                        ),
                      ],
                    ),
                  ],
                ));
          }

          return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          // Image radius
                          child: Image(
                            image: NetworkImage(widget.post.user.pp),
                            width: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.user.pseudo,
                                style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              widget.post.location.item2 != null
                                  ? Text(
                                      "${widget.post.location?.item1}, ${widget.post.location?.item2}",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white.withOpacity(0.4),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13),
                                    )
                                  : Text(
                                      "",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white.withOpacity(0.4),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13),
                                    )
                            ],
                          ),
                        ),
                      ),
                      DateTime(today.year, today.month, today.day).isAtSameMomentAs(
                              DateTime(widget.post.date.year, widget.post.date.month, widget.post.date.day))
                          ? Text(
                              "Aujourd'hui, ${widget.post.date.hour}:${widget.post.date.minute}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 13),
                            )
                          : Text(
                              "${widget.post.date.day}/${widget.post.date.month}/${widget.post.date.year}-${widget.post.date.hour}:${widget.post.date.minute}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 13),
                            ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ZoomTapAnimation(
                      onTap: () {
                        widget.callback!(widget.index);
                      },
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      end: 0.99,
                      beginDuration: const Duration(milliseconds: 70),
                      endDuration: const Duration(milliseconds: 100),
                      beginCurve: Curves.decelerate,
                      endCurve: Curves.easeInOutSine,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          decoration: BoxDecoration(
                            // add border
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                Colors.transparent,
                                Color(0xFF323232),
                              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                              width: 2.5,
                            ),
                            // set border radius
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            // implement image
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image(
                                  image: NetworkImage(widget.post.music.cover!),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Image(
                                  image: AssetImage("assets/images/shadow_post.png"),
                                  fit: BoxFit.fitHeight,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: AutoSizeText(
                                    '“${widget.post.description}”',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15.sp),
                                    maxFontSize: 20,
                                    maxLines: 1,
                                  ),
                                ),
                                widget.post.selfie != null
                                    ? Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Container(
                                            constraints: BoxConstraints(maxWidth: 140, maxHeight: 140),
                                            width: 90.sp,
                                            height: 90.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              // add border
                                              border: Border.all(width: 3, color: Colors.white),
                                              // set border radius
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(13),
                                              // implement image
                                              child: Image(
                                                image: NetworkImage(widget.post.selfie!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 8,
                          child: TextScroll(
                            widget.post.music.artists.first.name!,
                            style: GoogleFonts.plusJakartaSans(
                                height: 1, color: Colors.white, fontWeight: FontWeight.w600, fontSize: 26.h),
                            mode: TextScrollMode.endless,
                            pauseBetween: Duration(milliseconds: 500),
                            velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h, right: 5.w, left: 5.w),
                        child: ClipOval(
                          child: Container(
                            width: 5.h,
                            height: 5.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: TextScroll(
                              widget.post.music.title!,
                              style: GoogleFonts.plusJakartaSans(
                                  height: 1, color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.h),
                              mode: TextScrollMode.endless,
                              velocity: Velocity(pixelsPerSecond: Offset(50, 20)),
                              pauseBetween: Duration(milliseconds: 500),
                            ),
                          )),
                      Container(width: 10),
                      AutoSizeText(
                        widget.post.music.date.toString(),
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w300, fontSize: 16.h),
                        textAlign: TextAlign.end,
                        maxFontSize: 20,
                      ),
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
