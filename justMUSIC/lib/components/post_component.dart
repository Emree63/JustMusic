import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:text_scroll/text_scroll.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage("assets/images/exemple_profile.png"),
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
                        "Melina",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "France, Lyon",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.4),
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "Aujourd’hui, 16:43",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white.withOpacity(0.4),
                    fontWeight: FontWeight.w300,
                    fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              width: 300,
              height: 300,
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
                      image: AssetImage("assets/images/exemple_cover.png"),
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
                        '“J’écoute en boucle ce son. B2O<3”',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp),
                        maxFontSize: 20,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 8,
                  child: TextScroll(
                    "BOOBA",
                    style: GoogleFonts.plusJakartaSans(
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 26.h),
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
                      "A.C. Milan",
                      style: GoogleFonts.plusJakartaSans(
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.h),
                      mode: TextScrollMode.endless,
                      velocity: Velocity(pixelsPerSecond: Offset(50, 20)),
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
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
