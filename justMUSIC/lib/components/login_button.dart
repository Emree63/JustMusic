import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF1C1C1C)),
        overlayColor:
            MaterialStateProperty.all(Color(0xffD3C2FF).withOpacity(0.2)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        )),
        padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 3),
            focalRadius: 10,
            radius: 2.5,
            stops: <double>[0.4, 1.0],
            colors: [Color(0xff9E78FF), Color(0xff633AF4)],
          ),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: Color(0xff1C1C1C),
            width: 5,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
          constraints: BoxConstraints(maxWidth: 600, minHeight: 50),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff7E56F9).withOpacity(0.23),
                spreadRadius: 4,
                blurRadius: 40,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            "Se connecter",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
