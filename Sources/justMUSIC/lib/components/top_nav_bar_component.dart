import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/routes.dart';
import '../values/constants.dart';

class TopNavBarComponent extends StatefulWidget {
  final Function(bool) callback;
  const TopNavBarComponent({Key? key, required this.callback})
      : super(key: key);

  @override
  State<TopNavBarComponent> createState() => _TopNavBarComponentState();
}

class _TopNavBarComponentState extends State<TopNavBarComponent> {
  bool choice = true;

  void actionSurBouton() {
    widget.callback(choice);
  }

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
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/post');
                },
                child: const Image(
                  image: AssetImage("assets/images/add_friend.png"),
                  width: 25,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 170),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!choice) {
                            setState(() {
                              choice = !choice;
                              actionSurBouton();
                            });
                          }
                        },
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            if (choice) {
                              return AutoSizeText(
                                "Mes amis",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              );
                            } else {
                              return AutoSizeText(
                                "Mes amis",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: unactiveFeed),
                              );
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (choice) {
                            setState(() {
                              choice = !choice;
                              actionSurBouton();
                            });
                          }
                        },
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            if (choice) {
                              return AutoSizeText(
                                "Discovery",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: unactiveFeed),
                              );
                            } else {
                              return AutoSizeText(
                                "Discovery",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(createRoute());
                },
                child: ClipOval(
                  child: SizedBox.fromSize(
                    // Image radius
                    child: const Image(
                      image: AssetImage("assets/images/exemple_profile.png"),
                      width: 25,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
