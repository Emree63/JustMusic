import 'package:flutter/Material.dart';

import '../values/constants.dart';

class ButtonPostComponent extends StatelessWidget {
  const ButtonPostComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      color: postbutton,
    );
  }
}
