import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        "Rejoindre",
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800, fontSize: 17),
      ),
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all(const Size(800, 50)),
        minimumSize: MaterialStateProperty.all(const Size(500, 50)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        )),
      ),
    );
  }
}
