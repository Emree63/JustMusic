import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:justmusic/values/constants.dart';

class EditablePostComponent extends StatefulWidget {
  final Function callback;
  const EditablePostComponent({Key? key, required this.callback})
      : super(key: key);

  @override
  State<EditablePostComponent> createState() => _EditablePostComponentState();
}

class _EditablePostComponentState extends State<EditablePostComponent> {
  final ImagePicker picker = ImagePicker();
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
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, minHeight: 500),
          width: double.infinity,
          color: warningBttnColor,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AspectRatio(
                  aspectRatio: 1 / 1,
                  child: GestureDetector(
                    onTap: () {
                      print("cc");
                      widget.callback;
                    },
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
                        child: const Image(
                          image: AssetImage("assets/images/exemple_cover.png"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                bottom: 40,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "France, Lyon",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 13.sp),
                        maxFontSize: 20,
                      ),
                      image == null
                          ? GestureDetector(
                              child: Image(
                                image:
                                    AssetImage("assets/images/camera_icon.png"),
                                width: 30,
                              ),
                              onTap: () {
                                print("cc2");

                                pickImage();
                              },
                            )
                          : Container(
                              height: 80,
                              width: 80,
                              child: Image.file(image!),
                            ),
                      AutoSizeText(
                        "10 Juil. 2023",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 13.sp),
                        maxFontSize: 20,
                      ),
                    ],
                  ),
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
}
