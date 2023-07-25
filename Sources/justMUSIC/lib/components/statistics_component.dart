import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';

class StatisticsComponent extends StatelessWidget {
  const StatisticsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            children: [
              AutoSizeText(
                "114",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.w),
                maxFontSize: 30,
              ),
              AutoSizeText(
                "Suivis",
                style: GoogleFonts.plusJakartaSans(
                    color: grayText, fontSize: 12.w),
                maxFontSize: 30,
              )
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              "5",
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.w),
              maxFontSize: 30,
            ),
            AutoSizeText(
              "Followers",
              style:
                  GoogleFonts.plusJakartaSans(color: grayText, fontSize: 12.w),
              maxFontSize: 30,
            )
          ],
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                "34",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.w),
                maxFontSize: 30,
              ),
              AutoSizeText(
                "Capsules",
                style: GoogleFonts.plusJakartaSans(
                    color: grayText, fontSize: 12.w),
                maxFontSize: 30,
              )
            ],
          ),
        ),
      ],
    );
  }
}
