import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:justmusic/model/Comment.dart';

import '../values/constants.dart';

class CommentComponent extends StatelessWidget {
  final Comment comment;
  const CommentComponent({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(comment.date);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: bgComment, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              // Image radius
              child: Image(
                image: NetworkImage(comment.user.pp),
                width: 40,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      comment.user.pseudo,
                      style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6, left: 10),
                      child: Text(
                        "il y a ${difference.inHours}h",
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
                    comment.text,
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
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
