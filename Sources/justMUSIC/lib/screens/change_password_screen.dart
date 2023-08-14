import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';

import '../values/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordTextField = TextEditingController();
  final _newPasswordTextField = TextEditingController();
  final _confirmPasswordTextField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  handleChange() async {
    print("test");
    if (_formKey.currentState!.validate()) {
      var error;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: MyApp.userViewModel.userCurrent.mail,
          password: _currentPasswordTextField.text,
        );
        if (_newPasswordTextField.text == _confirmPasswordTextField.text) {
          await FirebaseAuth.instance.currentUser?.updatePassword(_confirmPasswordTextField.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Mot de passe mis à jour",
                style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15.h),
              ),
              backgroundColor: primaryColor,
              closeIconColor: Colors.white,
            ),
          );
        } else {
          throw FirebaseAuthException(code: "not-same", message: "Les mots de passe ne correspondent pas");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "wrong-password") {
          error = "Mot de passe incorrect";
        } else if (e.code == "too-many-requests") {
          error = "Trop de tentatives infructueuses. Veuillez réessayer plus tard";
        } else if (e.code == "channel-error") {
          error = "Impossible de vérifier le mot de passe";
        } else if (e.code == "weak-password") {
          error = "Le mot de passe doit contenir 6 caractères minimum";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error ?? e.message,
              style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15.h),
            ),
            backgroundColor: Colors.red,
            closeIconColor: Colors.white,
          ),
        );
      }
      setState(() {
        _currentPasswordTextField.clear();
        _newPasswordTextField.clear();
        _confirmPasswordTextField.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          resetFullScreen();
        }
      },
      child: Scaffold(
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
                      "Mettre le mot de passe à jour",
                      style:
                          GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
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
                      child: Form(
                        key: _formKey,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: 600),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Mot de passe actuel",
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                      )),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _currentPasswordTextField,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              // Hides the border when you click the TextField
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              // Hides the border when the TextField is disabled
                                              disabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              filled: true,
                                              hintText: '6 caractères minimum',
                                              hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField)),
                                          maxLines: 1,
                                          obscureText: true,
                                          cursorColor: primaryColor,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: grayText, fontWeight: FontWeight.w400, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Nouveau mot de passe",
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                      )),
                                      Expanded(
                                        child: TextField(
                                          controller: _newPasswordTextField,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              // Hides the border when you click the TextField
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              // Hides the border when the TextField is disabled
                                              disabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              filled: true,
                                              hintText: '6 caractères minimum',
                                              hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField)),
                                          maxLines: 1,
                                          obscureText: true,
                                          cursorColor: primaryColor,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: grayText, fontWeight: FontWeight.w400, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Confirmer",
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                      )),
                                      Expanded(
                                        child: TextField(
                                          obscureText: true,
                                          controller: _confirmPasswordTextField,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              // Hides the border when you click the TextField
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              // Hides the border when the TextField is disabled
                                              disabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                              ),
                                              filled: true,
                                              hintText: '6 caractères minimum',
                                              hintStyle: GoogleFonts.plusJakartaSans(color: strokeTextField)),
                                          maxLines: 1,
                                          cursorColor: primaryColor,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: grayText, fontWeight: FontWeight.w400, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: handleChange,
                    child: Align(
                      child: Container(
                        height: 35,
                        width: 160,
                        decoration:
                            BoxDecoration(color: primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "Mettre à jour",
                            style: GoogleFonts.plusJakartaSans(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
