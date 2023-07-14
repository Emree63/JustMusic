import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/constants.dart';

import '../components/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Align(
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Text(
                  "Te revoilà!",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 38),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 230,
                  child: Text(
                    "Bon retour parmis nous tu nous as manqué!",
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                LoginButton()
              ],
            ))
          ],
        ),
      ),
    );
  }
}
