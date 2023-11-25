import 'dart:io';
import 'package:animated_appear/animated_appear.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:justmusic/values/constants.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tuple/tuple.dart';

import '../model/Music.dart';
import '../screens/search_location_screen.dart';
import 'buttonPostComponent.dart';

class EditablePostComponent extends StatefulWidget {
  final Music? music;
  final Function callBackImage;
  final Function callBackCity;
  final Function callBackDescription;
  const EditablePostComponent(
      {Key? key,
      this.music,
      required this.callBackImage,
      required this.callBackCity,
      required this.callBackDescription})
      : super(key: key);

  @override
  State<EditablePostComponent> createState() => _EditablePostComponentState();
}

class _EditablePostComponentState extends State<EditablePostComponent> with TickerProviderStateMixin {
  final ImagePicker picker = ImagePicker();
  late Animation<double> animation;
  late AnimationController animationController;
  late AnimationController _controller;
  File? image;
  Tuple2<String, String>? selectedCity;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 20);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        widget.callBackImage(imageTemp);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _updateDescription(String text) {
    setState(() {
      widget.callBackDescription(text);
    });
  }

  void _selectLocation(Tuple2<String, String> location) {
    Navigator.pop(context);
    setState(() {
      selectedCity = location;
      widget.callBackCity(location);
    });
  }

  void searchLocation() {
    showModalBottomSheet(
      transitionAnimationController: _controller,
      barrierColor: Colors.black.withOpacity(0.7),
      backgroundColor: Colors.transparent,
      elevation: 1,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: ((context) {
        return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: SearchCityScreen(callback: _selectLocation));
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
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
              Stack(
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
                                width: double.infinity,
                                child: Center(
                                  child: Icon(
                                    Icons.headphones,
                                    color: grayColor.withOpacity(0.4),
                                    size: 150,
                                  ),
                                ),
                              )
                            : FadeInImage.assetNetwork(
                                image: widget.music!.cover!,
                                fit: BoxFit.cover,
                                fadeInDuration: const Duration(milliseconds: 100),
                                placeholder: "assets/images/loadingPlaceholder.gif",
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
                                  border: Border.all(style: BorderStyle.solid, color: Colors.white, width: 4)),
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
              ),
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
                          Flexible(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: TextScroll(
                                  (widget.music?.artists[0].name)!,
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1, color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.h),
                                  mode: TextScrollMode.endless,
                                  velocity: Velocity(pixelsPerSecond: Offset(50, 20)),
                                  pauseBetween: Duration(milliseconds: 500),
                                ),
                              )),
                          Container(width: 10),
                          AutoSizeText(
                            widget.music?.date.toString() ?? "unknown",
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w300, fontSize: 16.h),
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
                      child: GestureDetector(
                        onTap: () {
                          manageLocation();
                        },
                        child: LocationPostComponent(
                          empty: selectedCity == null,
                          location: selectedCity,
                        ),
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
                        keyboardType: TextInputType.text,
                      onChanged: (value) {
                        _updateDescription(value);
                      },
                      keyboardAppearance: Brightness.dark,
                      minLines: 1,
                      cursorColor: primaryColor,
                      style:
                          GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w300),
                      maxLines: 4,
                      maxLength: 120,
                      decoration: InputDecoration(
                        counterStyle: GoogleFonts.plusJakartaSans(color: grayText, fontSize: 9),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 0),
                        fillColor: Colors.transparent,
                        filled: true,
                        focusColor: Colors.transparent,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'Description...',
                        hintStyle:
                            GoogleFonts.plusJakartaSans(color: grayText, fontSize: 13, fontWeight: FontWeight.w300),
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
      _showActionSheet(context);
    }
  }

  void manageLocation() {
    if (selectedCity != null) {
      setState(() {
        selectedCity = null;
      });
    } else {
      searchLocation();
    }
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => Container(
        color: Colors.black,
        child: CupertinoActionSheet(
          title: Text(
            'Ajouter une photo',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: const Text('Galerie'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: const Text('Prendre un selfie'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Annuler'),
          ),
        ),
      ),
    );
  }
}
