import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/historic_component.dart';
import '../values/constants.dart';
import 'package:intl/intl.dart';

class CapsuleHistoricScreen extends StatefulWidget {
  const CapsuleHistoricScreen({super.key});

  @override
  State<CapsuleHistoricScreen> createState() => _CapsuleHistoricScreenState();
}

class _CapsuleHistoricScreenState extends State<CapsuleHistoricScreen> {
  DateTime date = DateTime.now();

  _reduceMonth() {
    setState(() {
      date = DateTime(date.year, date.month - 1, date.day);
    });
  }

  _addMonth() {
    setState(() {
      date = DateTime(date.year, date.month + 1, date.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 58),
        child: Container(
          height: double.infinity,
          color: bgAppBar,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/return_icon.png"),
                        height: 8,
                      ),
                    )),
                Align(
                  child: Text(
                    "Historique des capsules",
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: settingPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 80, left: 60, right: 60),
                  constraints: const BoxConstraints( maxWidth: 450),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            width: 30,
                            child: Image(
                              image: AssetImage("assets/images/return_icon.png"),
                              height: 8,
                            ),
                          ),
                          onTap: _reduceMonth,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            '${DateFormat.MMMM('fr_FR').format(date)[0].toUpperCase()}${DateFormat.MMMM('fr_FR').format(date).substring(1)} ${date.year}',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: _addMonth,
                          child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(3.14159265),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 30,
                                width: 30,
                                child: Image(
                                  image: AssetImage("assets/images/return_icon.png"),
                                  height: 8,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 40),
                  child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            HistoricComponent(
                              month: date.month,
                              year: date.year,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
