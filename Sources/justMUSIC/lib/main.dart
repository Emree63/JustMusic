import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justmusic/screens/add_friend_screen.dart';
import 'package:justmusic/screens/explanations_screen.dart';
import 'package:justmusic/screens/feed_screen.dart';
import 'package:justmusic/screens/forget_password_screen.dart';
import 'package:justmusic/screens/login_screen.dart';
import 'package:justmusic/screens/launching_rocker_screen.dart';
import 'package:justmusic/screens/post_screen.dart';
import 'package:justmusic/screens/profile_screen.dart';
import 'package:justmusic/screens/registration_screen.dart';
import 'package:justmusic/screens/verify_email_screen.dart';
import 'package:justmusic/screens/welcome_screen.dart';
import 'package:justmusic/view_model/CommentViewModel.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';
import 'package:justmusic/view_model/PostViewModel.dart';
import 'package:justmusic/view_model/UserViewModel.dart';
import 'package:justmusic/model/User.dart' as userJustMusic;
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission(sound: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static UserViewModel userViewModel = UserViewModel();
  static MusicViewModel musicViewModel = MusicViewModel();
  static PostViewModel postViewModel = PostViewModel();
  static AudioPlayer audioPlayer = AudioPlayer();
  static CommentViewModel commentViewModel = CommentViewModel();
  static const keyManager = 'customCacheKey';

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  Stream<userJustMusic.User?> userCurrent = Stream.empty();

  @override
  void initState() {
    super.initState();
    checkSignIn();
  }

  Future<userJustMusic.User?> checkSignIn() async {
    user = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        print('User is currently signed out!');
        return null;
      } else {
        MyApp.userViewModel.userCurrent = (await (MyApp.userViewModel.getUser(user.uid)))!;
        userCurrent = Stream.value(MyApp.userViewModel.userCurrent);
        print('User is signed in!');
      }
    });
    return null;
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

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
              '/verifyEmail': (context) => const VerifyEmailScreen(),
              '/forgetPassword': (context) => const ForgetPasswordScreen(),
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: WellcomeScreen());
      },
      designSize: Size(390, 844),
    );
  }
}
