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
      decoration: BoxDecoration(color: bgComment, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Melina",
                      style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6, left: 10),
                      child: Text(
                        "Il y a 2 min(s)",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.w400, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "J’adore ce son aussi, je trouve qu’il avait vraiment une plume de fou.",
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 11),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
