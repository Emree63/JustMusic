import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/constants.dart';
import 'package:tuple/tuple.dart';

class CityListComponent extends StatelessWidget {
  final Tuple2<String, String> location;
  const CityListComponent({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(children: [
                    TextSpan(
                      text: location.item2 + ", ",
                      style: GoogleFonts.plusJakartaSans(
                          color: grayText,
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    ),
                    TextSpan(
                      text: location.item1,
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
