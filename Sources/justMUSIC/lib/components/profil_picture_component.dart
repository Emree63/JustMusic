import 'package:flutter/material.dart';
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
        child: SizedBox(
          height: 40,
          width: 40,
          // Image radius
          child: FadeInImage.assetNetwork(
            image: user.pp,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 100),
            placeholder: "assets/images/loadingPlaceholder.gif",
          ),
        ),
      ),
    );
  }
}
