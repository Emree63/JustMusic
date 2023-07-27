import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/components/play_button_component.dart';
import 'package:justmusic/values/constants.dart';

class MusicListComponent extends StatelessWidget {
  const MusicListComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image(
              image: AssetImage("assets/images/exemple_cover.png"),
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 10,
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.vertical,
              runSpacing: 3,
              spacing: 3,
              children: [
                Wrap(
                  verticalDirection: VerticalDirection.up,
                  spacing: 5,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.end,
                  alignment: WrapAlignment.end,
                  children: [
                    Text(
                      "A.C. Milan",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Icon(
                      Icons.explicit,
                      color: Colors.grey.withOpacity(0.7),
                      size: 17,
                    )
                  ],
                ),
                Text(
                  "Booba",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Spacer(),
          PlayButtonComponent()
        ],
      ),
    );
  }
}
