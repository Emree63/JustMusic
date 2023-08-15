import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';
import 'package:justmusic/values/constants.dart';

import '../components/login_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 5),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
      Navigator.pushNamed(context, '/explanation');
    }
  }

  cancel() {
    Navigator.pushNamed(context, '/register');
    MyApp.userViewModel.delete();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(minutes: 1));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.h),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                        padding: EdgeInsets.only(top: 200.h),
                        child: Align(
                          child: SizedBox(
                            width: 56.h,
                            child: Image(image: AssetImage("assets/images/plane_icon.png")),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 43.h),
                      child: AutoSizeText(
                        "Verification de ton Email",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.w),
                        maxLines: 1,
                        maxFontSize: 30,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 50.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 346.h,
                              child: AutoSizeText(
                                "Nous vous avons envoyé un lien de confirmation a l'adresse ${MyApp.userViewModel.userCurrent.mail}.\nVeuillez verifier votre messagerie et cliquer sur le lien pour vérifier votre Email.",
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white, fontWeight: FontWeight.w100, fontSize: 16.w),
                                maxFontSize: 20,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: SizedBox(
                          width: 600,
                          child: LoginButton(
                            callback: checkEmailVerified,
                            text: "Continuer",
                          )),
                    ),
                    Align(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          canResendEmail ? sendVerificationEmail() : null;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 55),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Renvoyer l’Email de confirmation',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15, fontWeight: FontWeight.w400, color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          cancel();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 43),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Revenir a l’étape précédente',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15, fontWeight: FontWeight.w400, color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.only(top: 45.h, left: defaultPadding, right: defaultPadding),
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
            )
          ],
        ));
  }
}
