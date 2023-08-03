import 'package:flutter/Material.dart';
import 'package:justmusic/screens/user_screen.dart';

import '../config/routes.dart';
import '../model/User.dart';

class ProfilPictureComponent extends StatelessWidget {
  final User user;
  const ProfilPictureComponent({super.key, required this.user});

  void _openDetail(BuildContext context) {
    print("cc");
    Navigator.of(context).push(routeUser(user));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDetail(context);
      },
      child: ClipOval(
        child: SizedBox.fromSize(
          // Image radius
          child: Image(
            image: NetworkImage(user.pp),
            width: 40,
          ),
        ),
      ),
    );
  }
}
