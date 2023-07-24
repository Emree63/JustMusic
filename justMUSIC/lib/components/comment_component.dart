import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgComment, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(
                width: 10,
              ),
              Text(
                "Melina",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6, left: 10),
                child: Text(
                  "Il y a 2 min(s)",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w200,
                      fontSize: 10),
                ),
              ),
            ],
          ),
          Text(
            "J’adore ce son auss je trouve qu’il a vraiment une plume de fou le rap c’est trop bien  jknei rhozi ugzeor gzhjkev huz vhzbejlh zouebvfiyzv fi hzejkfb zjf ouzebfjzebihf b zuib fiuzebfihzbejfbzejkbf  hzbfiébiu zegiu fzieu iuzy giuzeg iuzg eiu zg ",
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white.withOpacity(0.4),
                fontWeight: FontWeight.w300,
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}
