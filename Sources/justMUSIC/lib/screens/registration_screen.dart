import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/constants.dart';

import '../components/login_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: AutoSizeText(
                    "On a besoin de ça!",
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.w),
                    maxLines: 1,
                    maxFontSize: 50,
                    overflow: TextOverflow.fade,
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 50.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  width: 230.h,
                                  child: AutoSizeText(
                                    "Promis c’est rapide.",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17.w),
                                    maxFontSize: 20,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: 16.h,
                                left: defaultPadding,
                                right: defaultPadding),
                            child: TextFormField(
                              keyboardAppearance: Brightness.dark,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'TODO';
                                }
                                return null;
                              },
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.plusJakartaSans(
                                  color: primaryColor, fontSize: 15),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.sp, color: strokeTextField),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: const EdgeInsets.only(
                                      top: 0, bottom: 0, left: defaultPadding),
                                  fillColor: bgTextField,
                                  filled: true,
                                  focusColor:
                                      const Color.fromRGBO(255, 255, 255, 0.30),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: strokeTextField),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Pseudo',
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                      color: strokeTextField)),
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: 16.h,
                                left: defaultPadding,
                                right: defaultPadding),
                            child: TextFormField(
                              keyboardAppearance: Brightness.dark,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'TODO';
                                }
                                return null;
                              },
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.plusJakartaSans(
                                  color: primaryColor),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: strokeTextField),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: EdgeInsets.only(
                                      top: 0, bottom: 0, left: defaultPadding),
                                  fillColor: bgTextField,
                                  filled: true,
                                  focusColor:
                                      Color.fromRGBO(255, 255, 255, 0.30),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: strokeTextField),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                      color: strokeTextField)),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 16.h,
                              left: defaultPadding,
                              right: defaultPadding),
                          child: TextFormField(
                            keyboardAppearance: Brightness.dark,
                            obscureText: passenable,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'TODO';
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.plusJakartaSans(
                                color: primaryColor),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: strokeTextField),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: defaultPadding),
                              fillColor: bgTextField,
                              filled: true,
                              focusColor: Color.fromRGBO(255, 255, 255, 0.30),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: strokeTextField),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Mot de passe',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                  color: strokeTextField),
                              suffixIcon: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  margin: EdgeInsets.all(5),
                                  height: 3,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (passenable) {
                                          passenable = false;
                                        } else {
                                          passenable = true;
                                        }
                                      });
                                    }, // Image tapped
                                    splashColor: Colors
                                        .white10, // Splash color over image
                                    child: Image(
                                      image: passenable
                                          ? AssetImage(
                                              "assets/images/show_icon.png")
                                          : AssetImage(
                                              "assets/images/hide_icon.png"),
                                      height: 2,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 16.h,
                              left: defaultPadding,
                              right: defaultPadding),
                          child: TextFormField(
                            keyboardAppearance: Brightness.dark,
                            obscureText: passenable,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'TODO';
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.plusJakartaSans(
                                color: primaryColor),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: strokeTextField),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: defaultPadding),
                              fillColor: bgTextField,
                              filled: true,
                              focusColor: Color.fromRGBO(255, 255, 255, 0.30),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: strokeTextField),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Confirmation du Mot de passe',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                  color: strokeTextField),
                              suffixIcon: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  margin: EdgeInsets.all(5),
                                  height: 3,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (passenable) {
                                          passenable = false;
                                        } else {
                                          passenable = true;
                                        }
                                      });
                                    }, // Image tapped
                                    splashColor: Colors
                                        .white10, // Splash color over image
                                    child: Image(
                                      image: passenable
                                          ? AssetImage(
                                              "assets/images/show_icon.png")
                                          : AssetImage(
                                              "assets/images/hide_icon.png"),
                                      height: 2,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: SizedBox(
                              width: 600,
                              child: LoginButton(
                                callback: () {},
                              )),
                        ),
                      ],
                    )),
                SizedBox(height: 50.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          color: Color(0xFF3D3D3D),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: defaultPadding, right: defaultPadding),
                        child: Text(
                          'Ou',
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Color(0xFF3D3D3D),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 47.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 540),
                  child: SizedBox(
                    width: 300.sp,
                    height: 50,
                    child: SignInButton(
                      Buttons.Google,
                      text: "Login with Google",
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
              ],
            ),
          )),
          IgnorePointer(
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topRight, stops: [
                0,
                1
              ], colors: [
                bgColor.withOpacity(1),
                bgColor.withOpacity(0)
              ])),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 45.h, left: defaultPadding, right: defaultPadding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    value: 0.5,
                    backgroundColor: grayColor,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
