import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/components/statistics_component.dart';

import '../model/User.dart';

class ProfileComponent extends StatelessWidget {
  final User user;
  const ProfileComponent({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: Image(
              image: NetworkImage(user.pp),
              height: 100.w,
              width: 100.w,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onLongPress: () async {
            await Clipboard.setData(ClipboardData(text: user.uniquePseudo));
          },
          child: AutoSizeText(
            "${user.pseudo}",
            style: GoogleFonts.plusJakartaSans(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w400),
            maxFontSize: 30,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        StatisticsComponent(
          user: user,
        ),
      ],
    );
  }
}
