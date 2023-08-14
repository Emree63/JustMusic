import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/main.dart';

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
        Duration(seconds: 3),
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
    Navigator.pushNamed(context, '/welcome');
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
            e.toString() ?? "",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verify Email'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('A verification email has been sent to your email.',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.email, size: 32),
                label: Text(
                  'ResentEmail',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: canResendEmail ? sendVerificationEmail : null,
              ),
              SizedBox(height: 8),
              TextButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: cancel,
              )
            ])));
  }
}
