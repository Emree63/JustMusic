import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justmusic/screens/add_friend_screen.dart';
import 'package:justmusic/screens/explanations_screen.dart';
import 'package:justmusic/screens/feed_screen.dart';
import 'package:justmusic/screens/login_screen.dart';
import 'package:justmusic/screens/launching_rocker_screen.dart';
import 'package:justmusic/screens/post_screen.dart';
import 'package:justmusic/screens/profile_screen.dart';
import 'package:justmusic/screens/registration_screen.dart';
import 'package:justmusic/screens/welcome_screen.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';
import 'package:justmusic/view_model/PostViewModel.dart';
import 'package:justmusic/view_model/UserViewModel.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static UserViewModel userViewModel = UserViewModel();
  static MusicViewModel musicViewModel = MusicViewModel();
  static PostViewModel postViewModel = PostViewModel();
  static AudioPlayer audioPlayer = AudioPlayer();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Paint.enableDithering = true;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
            routes: {
              '/welcome': (context) => const WellcomeScreen(),
              '/feed': (context) => const FeedScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegistrationScreen(),
              '/post': (context) => const PostScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/explanation': (context) => const ExplanationsScreen(),
              '/addFriend': (context) => const AddFriendScreen(),
              '/launchingRocket': (context) => const LaunchingRocketScreen(),
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: WellcomeScreen());
      },
      designSize: Size(390, 844),
    );
  }
}
