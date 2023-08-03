import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';
import 'little_post_recap_component.dart';
import 'package:intl/intl.dart';

class RecapComponent extends StatelessWidget {
  const RecapComponent({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> weekDays = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    DateTime currentDate = DateTime.now();

    return Container(
      decoration: BoxDecoration(
          color: profileBttnColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: grayColor, width: 1)),
      height: 120,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: postbutton,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 6)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 5)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 4)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 3)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 2)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 1)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
                Flexible(
                    child: Center(
                  child: Text(
                    weekDays[currentDate.subtract(Duration(days: 0)).weekday - 1].substring(0, 1),
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                )),
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LittleCapsule(
                  isEmpty: false,
                  date: DateTime.now(),
                ),
                LittleCapsule(isEmpty: true, date: currentDate.subtract(const Duration(days: 5))),
                LittleCapsule(isEmpty: false, date: currentDate.subtract(const Duration(days: 4))),
                LittleCapsule(isEmpty: false, date: currentDate.subtract(const Duration(days: 3))),
                LittleCapsule(isEmpty: false, date: currentDate.subtract(const Duration(days: 2))),
                LittleCapsule(isEmpty: false, date: currentDate.subtract(const Duration(days: 1))),
                LittleCapsule(isEmpty: false, date: currentDate.subtract(const Duration(days: 0))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
