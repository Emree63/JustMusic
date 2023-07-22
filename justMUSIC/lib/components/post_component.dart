import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF3A3A3A),
                  spreadRadius: 0.5,
                  blurRadius: 0,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Padding(
                padding: EdgeInsets.all(1.5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: const [
                        Image(
                          image: AssetImage("assets/images/exemple_cover.png"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Image(
                          image: AssetImage("assets/images/shadow_post.png"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                "BOOBA",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 26.sp),
                maxFontSize: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: AutoSizeText(
                  "A.C. Milan",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp),
                  maxFontSize: 20,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "2013",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp),
                  textAlign: TextAlign.end,
                  maxFontSize: 20,
                ),
              )
            ],
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
