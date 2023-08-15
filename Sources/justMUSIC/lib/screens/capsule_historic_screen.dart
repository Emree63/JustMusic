import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/historic_component.dart';
import '../values/constants.dart';

class CapsuleHistoricScreen extends StatefulWidget {
  const CapsuleHistoricScreen({super.key});

  @override
  State<CapsuleHistoricScreen> createState() => _CapsuleHistoricScreenState();
}

class _CapsuleHistoricScreenState extends State<CapsuleHistoricScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          constraints: BoxConstraints(maxWidth: 600),
                          child: Column(
                            children: [
                              HistoricComponent(
                                month: DateTime.now().month,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
