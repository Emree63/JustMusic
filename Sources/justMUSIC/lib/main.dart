import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'package:justmusic/values/constants.dart';
import 'package:justmusic/view_model/CommentViewModel.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';
import 'package:justmusic/view_model/PostViewModel.dart';
import 'package:justmusic/view_model/UserViewModel.dart';
import 'package:justmusic/model/User.dart' as userJustMusic;
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  tz.initializeTimeZones();
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized(); // Initialize for French locale

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('fr_FR', null);
  if (!kIsWeb) {
    await FirebaseMessaging.instance.requestPermission(sound: true);
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static UserViewModel userViewModel = UserViewModel();
  static MusicViewModel musicViewModel = MusicViewModel();
  static PostViewModel postViewModel = PostViewModel();
  static AudioPlayer audioPlayer = AudioPlayer();
  static CommentViewModel commentViewModel = CommentViewModel();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
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
            color: bgColor,
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
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (ConnectionState.waiting == snapshot.connectionState) {
                    return const CupertinoActivityIndicator();
                  }
                  if (snapshot.hasData) {
                    return FutureBuilder<userJustMusic.User?>(
                      future: MyApp.userViewModel.getUser(snapshot.data!.uid),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return const CupertinoActivityIndicator();
                        } else {
                          if (userSnapshot.hasData) {
                            MyApp.userViewModel.userCurrent = userSnapshot.data!;
                            return FeedScreen();
                          } else {
                            return WellcomeScreen();
                          }
                        }
                      },
                    );
                  } else {
                    return WellcomeScreen();
                  }
                }));
      },
      designSize: Size(390, 844),
    );
  }
}
