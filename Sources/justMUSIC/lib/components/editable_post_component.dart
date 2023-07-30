import 'dart:io';

import 'package:animated_appear/animated_appear.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:justmusic/values/constants.dart';
import 'package:text_scroll/text_scroll.dart';

import '../model/Music.dart';
import 'buttonPostComponent.dart';

class EditablePostComponent extends StatefulWidget {
  final Music? music;
  const EditablePostComponent({Key? key, this.music}) : super(key: key);

  @override
  State<EditablePostComponent> createState() => _EditablePostComponentState();
}

class _EditablePostComponentState extends State<EditablePostComponent>
    with TickerProviderStateMixin {
  final ImagePicker picker = ImagePicker();
  late Animation<double> animation;
  late AnimationController animationController;
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutSine,
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, minHeight: 500),
          width: double.infinity,
          color: warningBttnColor,
          child: Column(
            children: [
              CircularRevealAnimation(
                  animation: animation,
                  centerOffset: Offset(30.w, -100),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          decoration: BoxDecoration(
                            // add border
                            border: Border.all(width: 3.0, color: grayColor),
                            // set border radius
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            // implement image
                            child: widget.music == null
                                ? Container(
                                    color: grayColor,
                                    width: double.infinity,
                                  )
                                : Image(
                                    image:
                                        NetworkImage(widget.music?.cover ?? ""),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                          ),
                        ),
                      ),
                      image != null
                          ? Positioned(
                              top: 10,
                              right: 10,
                              child: AnimatedAppear(
                                delay: Duration(milliseconds: 500),
                                duration: Duration(milliseconds: 400),
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(image!),
                                        fit: BoxFit.cover,
                                      ),
                                      color: grayColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Colors.white,
                                          width: 4)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InstaImageViewer(
                                      backgroundIsTransparent: true,
                                      child: Image(
                                        image: FileImage(image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          : Container()
                    ],
                  )),
              widget.music != null
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 8,
                              child: TextScroll(
                                (widget.music?.title)!,
                                style: GoogleFonts.plusJakartaSans(
                                    height: 1,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 26.h),
                                mode: TextScrollMode.endless,
                                pauseBetween: Duration(milliseconds: 500),
                                velocity:
                                    Velocity(pixelsPerSecond: Offset(20, 0)),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 10.h, right: 5.w, left: 5.w),
                            child: ClipOval(
                              child: Container(
                                width: 5.h,
                                height: 5.h,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: TextScroll(
                                  (widget.music?.artists[0].name)!,
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.h),
                                  mode: TextScrollMode.endless,
                                  velocity:
                                      Velocity(pixelsPerSecond: Offset(50, 20)),
                                  pauseBetween: Duration(milliseconds: 500),
                                ),
                              )),
                          Container(width: 10),
                          AutoSizeText(
                            "2013",
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w300,
                                fontSize: 16.h),
                            textAlign: TextAlign.end,
                            maxFontSize: 20,
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {
                          manageImage();
                        },
                        child: PhotoPostComponent(
                          empty: image == null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 5,
                      child: LocationPostComponent(
                        empty: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      keyboardAppearance: Brightness.dark,
                      minLines: 1,
                      cursorColor: primaryColor,
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                      maxLines: 4,
                      maxLength: 120,
                      decoration: InputDecoration(
                        counterStyle: GoogleFonts.plusJakartaSans(
                            color: grayText, fontSize: 9),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 0),
                        fillColor: Colors.transparent,
                        filled: true,
                        focusColor: Colors.transparent,
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Description...',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: grayText,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  void manageImage() {
    if (image != null) {
      setState(() {
        image = null;
      });
    } else {
      pickImage();
    }
  }
}
