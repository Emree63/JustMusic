import 'package:flutter/Material.dart';
import 'package:justmusic/screens/add_friend_screen.dart';
import 'package:justmusic/screens/feed_screen.dart';
import 'package:justmusic/screens/profile_screen.dart';

Route routeProfile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route routeAddFriend() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const AddFriendScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route routeRocket() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => FeedScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
