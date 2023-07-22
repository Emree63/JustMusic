import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';

class TopNavBarComponent extends StatefulWidget {
  const TopNavBarComponent({Key? key}) : super(key: key);

  @override
  State<TopNavBarComponent> createState() => _TopNavBarComponentState();
}

class _TopNavBarComponentState extends State<TopNavBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              flex: 1,
              child: Image(
                image: AssetImage("assets/images/add_friend.png"),
                width: 25,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 170),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Mes amis",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: unactiveFeed),
                      ),
                      AutoSizeText(
                        "Discovery",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Flexible(
                flex: 1,
                child: Image(
                  image: AssetImage("assets/images/add_friend.png"),
                  width: 25,
                ))
          ],
        ),
      ),
    );
  }
}
