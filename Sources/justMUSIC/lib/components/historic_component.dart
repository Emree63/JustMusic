import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';
import 'package:justmusic/values/constants.dart';
import 'package:tuple/tuple.dart';

import '../model/Music.dart';

class HistoricComponent extends StatefulWidget {
  final int month;
  final int year;
  const HistoricComponent({super.key, required this.month, required this.year});

  @override
  State<HistoricComponent> createState() => _HistoricComponentState();
}

class _HistoricComponentState extends State<HistoricComponent> {
  int getNumberOfDaysInMonth(int year, int month) {
    if (month < 1 || month > 12) {
      throw ArgumentError("Le numéro de mois doit être compris entre 1 et 12.");
    }

    return DateTime(year, month + 1, 0).day;
  }

  getHistoric() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MyApp.musicViewModel
            .getHistoryCapsulesMonthWhitIdUser(MyApp.userViewModel.userCurrent.id, widget.month, widget.year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: List.generate(getNumberOfDaysInMonth(widget.year, widget.month), (index) {
                Tuple2<int, Music>? checkCapsule;
                if (snapshot.data != null) {
                  for (var element in snapshot.data!) {
                    if (element.item1 == index + 1) {
                      checkCapsule = element;
                    }
                  }
                }

                if ((widget.year > DateTime.now().year || widget.month > DateTime.now().month) ||
                    (widget.year == DateTime.now().year &&
                        widget.month == DateTime.now().month &&
                        index > DateTime.now().day)) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF1E1E1E).withOpacity(0.7),
                          Color(0xFF1E1E1E).withOpacity(0),
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(5)),
                    height: 60,
                    width: 60,
                  );
                }
                if (checkCapsule != null) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage((checkCapsule.item2.cover)!)),
                        borderRadius: BorderRadius.circular(5)),
                    height: 60,
                    width: 60,
                  );
                } else {
                  return Container(
                    color: bgColor,
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style:
                            GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                  );
                }

                // Generate widgets
              }),
            );
          } else {
            return CupertinoActivityIndicator();
          }
        });
  }
}
