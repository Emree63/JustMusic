import 'package:flutter/material.dart';

import '../values/constants.dart';

class BackButtonComponent extends StatefulWidget {
  const BackButtonComponent({Key? key}) : super(key: key);

  @override
  State<BackButtonComponent> createState() => _BackButtonComponentState();
}

class _BackButtonComponentState extends State<BackButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: ClipOval(
        child: Container(
          height: 40,
          width: 40,
          color: Colors.white,
          child: Center(
            child: Icon(
              Icons.arrow_back_outlined,
              color: bgColor,
            ),
          ),
        ),
      ),
    );
  }
}
