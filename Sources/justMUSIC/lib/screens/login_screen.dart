import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/constants.dart';

import '../components/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passenable = true;
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: bgColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight >= 740) {
                  return Align(
                    child: SizedBox(
                        height: double.infinity,
                        width: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 5,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 60),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Te revoilà!",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 38.h),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 230.w,
                                                      child: Text(
                                                        "Bon retour parmis nous tu nous as manqué!",
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 20.h),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'TODO';
                                                        }
                                                        return null;
                                                      },
                                                      cursorColor: primaryColor,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  primaryColor),
                                                      decoration: InputDecoration(
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      strokeTextField),
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10))),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0,
                                                                  bottom: 0,
                                                                  left:
                                                                      defaultPadding),
                                                          fillColor:
                                                              bgTextField,
                                                          filled: true,
                                                          focusColor: Color.fromRGBO(
                                                              255, 255, 255, 0.30),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      strokeTextField),
                                                              borderRadius:
                                                                  BorderRadius.all(Radius.circular(10))),
                                                          hintText: 'Email',
                                                          hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField)),
                                                    ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    TextFormField(
                                                      obscureText: passenable,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'TODO';
                                                        }
                                                        return null;
                                                      },
                                                      cursorColor: primaryColor,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  primaryColor),
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    strokeTextField),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 0,
                                                                left:
                                                                    defaultPadding),
                                                        fillColor: bgTextField,
                                                        filled: true,
                                                        focusColor:
                                                            Color.fromRGBO(255,
                                                                255, 255, 0.30),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    strokeTextField),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        hintText:
                                                            'Mot de passe',
                                                        hintStyle: GoogleFonts
                                                            .plusJakartaSans(
                                                                color:
                                                                    strokeTextField),
                                                        suffixIcon: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            height: 3,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (passenable) {
                                                                    passenable =
                                                                        false;
                                                                  } else {
                                                                    passenable =
                                                                        true;
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
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        "Mot de passe oublié?",
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: defaultPadding,
                                                    ),
                                                    SizedBox(
                                                        width: 600,
                                                        child: LoginButton()),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth: 600),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                color: Color(
                                                                    0xFF3D3D3D),
                                                                height: 1,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .only(
                                                                  left:
                                                                      defaultPadding,
                                                                  right:
                                                                      defaultPadding),
                                                              child: Text(
                                                                'Ou',
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    Container(
                                                              height: 1,
                                                              color: Color(
                                                                  0xFF3D3D3D),
                                                            )),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      SignInButton(
                                                        Buttons.Google,
                                                        text:
                                                            "Login with Google",
                                                        onPressed: () {},
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                            text:
                                                                'Pas encore inscrit?',
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      " S’inscire",
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          primaryColor)),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ))))
                          ],
                        )),
                  );
                } else {
                  return Align(
                    child: SizedBox(
                        height: double.infinity,
                        width: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 30),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Te revoilà!",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 38.h),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 230,
                                                      child: Text(
                                                        "Bon retour parmis nous tu nous as manqué!",
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 20.h),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'TODO';
                                                        }
                                                        return null;
                                                      },
                                                      cursorColor: primaryColor,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  primaryColor),
                                                      decoration: InputDecoration(
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      strokeTextField),
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10))),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0,
                                                                  bottom: 0,
                                                                  left:
                                                                      defaultPadding),
                                                          fillColor:
                                                              bgTextField,
                                                          filled: true,
                                                          focusColor: Color.fromRGBO(
                                                              255, 255, 255, 0.30),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      strokeTextField),
                                                              borderRadius:
                                                                  BorderRadius.all(Radius.circular(10))),
                                                          hintText: 'Email',
                                                          hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField, fontSize: 15)),
                                                    ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    TextFormField(
                                                      obscureText: passenable,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'TODO';
                                                        }
                                                        return null;
                                                      },
                                                      cursorColor: primaryColor,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  primaryColor),
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    strokeTextField),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 0,
                                                                left:
                                                                    defaultPadding),
                                                        fillColor: bgTextField,
                                                        filled: true,
                                                        focusColor:
                                                            Color.fromRGBO(255,
                                                                255, 255, 0.30),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    strokeTextField),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        hintText:
                                                            'Mot de passe',
                                                        hintStyle: GoogleFonts
                                                            .plusJakartaSans(
                                                                color:
                                                                    strokeTextField),
                                                        suffixIcon: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            height: 3,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (passenable) {
                                                                    passenable =
                                                                        false;
                                                                  } else {
                                                                    passenable =
                                                                        true;
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
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10.h),
                                                      child: Text(
                                                        "Mot de passe oublié?",
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: defaultPadding,
                                                    ),
                                                    SizedBox(
                                                        width: 600,
                                                        child: LoginButton()),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth: 600),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                color: Color(
                                                                    0xFF3D3D3D),
                                                                height: 1,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .only(
                                                                  left:
                                                                      defaultPadding,
                                                                  right:
                                                                      defaultPadding),
                                                              child: Text(
                                                                'Ou',
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    Container(
                                                              height: 1,
                                                              color: Color(
                                                                  0xFF3D3D3D),
                                                            )),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      SignInButton(
                                                        Buttons.Google,
                                                        text:
                                                            "Login with Google",
                                                        onPressed: () {},
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                            text:
                                                                'Pas encore inscrit?',
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      " S’inscire",
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          primaryColor)),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ))))
                          ],
                        )),
                  );
                }
              },
            )));
  }
}
