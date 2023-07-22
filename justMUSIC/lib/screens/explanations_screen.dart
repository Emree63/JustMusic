import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

import '../components/Finish_button.dart';

import '../values/constants.dart';

class ExplanationsScreen extends StatelessWidget {
  const ExplanationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 70.h),
                              child: AutoSizeText(
                                "Bravo!",
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32.w),
                                maxLines: 1,
                                maxFontSize: 50,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 250),
                                child: AutoSizeText(
                                  "Tu fais à présent parti de la communauté.",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15.w),
                                  maxFontSize: 20,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Align(
                              child: SizedBox(
                                width: 330.h,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/presentation.png")),
                              ),
                            ),
                            Align(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: AutoSizeText(
                                  "Découvre des sons",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 28.w),
                                  maxLines: 1,
                                  maxFontSize: 50,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: defaultPadding.h,
                                  bottom: defaultPadding.h),
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "Explore ton Feed d’amis et les découvertes, pour découvrir ce qu’écoute tes amis et bien d’autres.",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14.w),
                                  maxFontSize: 20,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 600, child: FinishButton()),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          IgnorePointer(
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topRight, stops: [
                0,
                1
              ], colors: [
                bgColor.withOpacity(1),
                bgColor.withOpacity(0)
              ])),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 45.h, left: defaultPadding, right: defaultPadding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    value: 1,
                    backgroundColor: grayColor,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
