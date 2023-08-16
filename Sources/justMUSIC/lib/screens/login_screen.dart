import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';
import 'package:justmusic/values/constants.dart';

import '../components/login_button.dart';
import '../exceptions/user_exception.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passenable = true;
  final _formKey = GlobalKey<FormState>();
  final _userMailTextField = TextEditingController();
  final _passwordTextField = TextEditingController();

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MyApp.userViewModel
            .login(_userMailTextField.text, _passwordTextField.text);
        Navigator.pushNamed(context, '/feed');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.h),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  signInWithGoogle() async {
    try {
      await MyApp.userViewModel.signInWithGoogle();
    } on UserException catch (e) {
      if (e.code == 'user-created') {
        Navigator.pushNamed(context, '/explanation');
      } else if (e.code == 'user-already-exist') {
        Navigator.pushNamed(context, '/feed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: bgColor,
            body: Align(
              child: SizedBox(
                  height: double.infinity,
                  width: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 40, right: 40),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 60),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Te revoilà!",
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 20.h),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              controller: _userMailTextField,
                                              keyboardAppearance:
                                                  Brightness.dark,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'entrez un email valide';
                                                }
                                                return null;
                                              },
                                              cursorColor: primaryColor,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      color: primaryColor),
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color:
                                                              strokeTextField),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  prefix: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.0)),
                                                  suffix: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.0)),
                                                  fillColor: bgTextField,
                                                  filled: true,
                                                  errorStyle: TextStyle(
                                                      fontSize: 9, height: 0.3),
                                                  focusColor: Color.fromRGBO(
                                                      255, 255, 255, 0.30),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide(width: 1, color: strokeTextField),
                                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  hintText: 'Email',
                                                  hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField)),
                                            ),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            TextFormField(
                                              controller: _passwordTextField,
                                              keyboardAppearance:
                                                  Brightness.dark,
                                              obscureText: passenable,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'entrez un mot de passe valide';
                                                }
                                                return null;
                                              },
                                              cursorColor: primaryColor,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      color: primaryColor),
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                strokeTextField),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                fillColor: bgTextField,
                                                filled: true,
                                                focusColor: Color.fromRGBO(
                                                    255, 255, 255, 0.30),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                strokeTextField),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                hintText: 'Mot de passe',
                                                hintStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: strokeTextField),
                                                prefix: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0)),
                                                suffixIcon: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
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
                                                      },
                                                      // Image tapped
                                                      splashColor:
                                                          Colors.white10,
                                                      // Splash color over image
                                                      child: Image(
                                                        image: passenable
                                                            ? AssetImage(
                                                                "assets/images/show_icon.png")
                                                            : AssetImage(
                                                                "assets/images/hide_icon.png"),
                                                        height: 2,
                                                      ),
                                                    )),
                                                errorStyle: TextStyle(
                                                    fontSize: 9, height: 0.3),
                                              ),
                                            ),
                                            GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/forgetPassword');
                                                },
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    "Mot de passe oublié?",
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                )),
                                            SizedBox(
                                              height: defaultPadding,
                                            ),
                                            SizedBox(
                                                width: 600,
                                                child: LoginButton(
                                                  callback: handleLogin,
                                                  text: "Se connecter",
                                                )),
                                            Align(
                                              child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/register');
                                                },
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      text:
                                                          'Pas encore inscrit?',
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 15),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: " S’inscire",
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        primaryColor)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 600),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          color:
                                                              Color(0xFF3D3D3D),
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
                                                          style: GoogleFonts
                                                              .plusJakartaSans(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        height: 1,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: defaultPadding),
                                                SignInButton(
                                                  Buttons.Google,
                                                  text: "Login with Google",
                                                  onPressed: signInWithGoogle,
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ))))
                    ],
                  )),
            )));
  }
}
