import 'package:flutter/material.dart';

import '../values/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image(
          image: AssetImage("assets/images/logo.png"),
          width: 130,
        ),
      ),
    );
  }
}
