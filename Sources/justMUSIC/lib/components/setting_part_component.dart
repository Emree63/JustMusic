import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/icons.dart';

import '../values/constants.dart';

class SettingPartComponent extends StatelessWidget {
  final JustMusicIcon icon;
  final String label;
  final bool important;
  const SettingPartComponent(
      {Key? key,
      required this.icon,
      required this.label,
      this.important = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: important ? warningBttnColor : settingColor,
      borderOnForeground: false,
      child: InkWell(
        onTap: () {
          print('InkWell was tapped!');
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.white.withOpacity(0.08),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                defaultPadding, 19, defaultPadding, 19),
            child: Row(
              children: [
                Image(
                  image: AssetImage(icon.imagePath),
                  width: 13,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                Spacer(),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159265),
                  child: Image(
                    image: AssetImage("assets/images/return_icon.png"),
                    height: 11,
                    opacity: const AlwaysStoppedAnimation(.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
