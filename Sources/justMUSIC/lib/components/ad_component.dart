import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justmusic/values/constants.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AdComponent extends StatefulWidget {
  final Container ad;
  const AdComponent({super.key, required this.ad});

  @override
  State<AdComponent> createState() => _AdComponentState();
}

class _AdComponentState extends State<AdComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: grayColor,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.information_circle,
                          color: grayText.withOpacity(0.4),
                          size: 15,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Sponsorisé",
                          style: GoogleFonts.plusJakartaSans(
                              color: grayText.withOpacity(0.4), fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(height: 10),
            widget.ad,
          ],
        ));
  }
}
