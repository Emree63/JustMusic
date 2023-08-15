import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/login_button.dart';
import '../values/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool canResendEmail = true;
  Timer? timer;
  final _formKey = GlobalKey<FormState>();
  final _mailTextField = TextEditingController();

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future sendForgetPasswordEmail() async {
    if (_formKey.currentState!.validate()) {
      var error;
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _mailTextField.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Un e-mail de réinitialisation a été envoyé. Veuillez patienter pendant 30 secondes avant la prochaine utilisation.",
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.h),
            ),
            backgroundColor: primaryColor,
          ),
        );
        setState(() => canResendEmail = false);
        await Future.delayed(Duration(minutes: 1));
        setState(() => canResendEmail = true);
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          error = "Mail incorrect";
        } else if (e.code == "user-not-found") {
          error = "Format de mail incorrect";
        } else if (e.code == "too-many-requests") {
          error =
              "Trop de tentatives. Veuillez réessayer plus tard";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Form(
            key: _formKey,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 185.h),
                            child: Align(
                              child: SizedBox(
                                width: 56.h,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/key_icon.png")),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 28.h),
                          child: AutoSizeText(
                            "Mot de passe oublié",
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.w),
                            maxLines: 1,
                            maxFontSize: 30,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  width: 346.h,
                                  child: AutoSizeText(
                                    "Afin de procéder à la récupération de votre mot de passe, veuillez renseigner votre adresse mail correspondant a votre compte JustMusic.",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 16.w),
                                    maxFontSize: 20,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 600),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 68.h,
                                          left: defaultPadding,
                                          right: defaultPadding),
                                      child: TextFormField(
                                        controller: _mailTextField,
                                        keyboardAppearance: Brightness.dark,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'entrez un email valide';
                                          }
                                          return null;
                                        },
                                        cursorColor: primaryColor,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: primaryColor),
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: strokeTextField),
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
                                            focusColor: Color.fromRGBO(
                                                255, 255, 255, 0.30),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: strokeTextField),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            hintText: 'Email',
                                            hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField)),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding),
                                    child: SizedBox(
                                        width: 600,
                                        child: LoginButton(
                                          callback: () {
                                            canResendEmail
                                                ? sendForgetPasswordEmail()
                                                : null;
                                          },
                                          text: "Envoyer",
                                        )),
                                  ),
                                ])),
                        Align(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 101),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Revenir a l’étape précédente',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
