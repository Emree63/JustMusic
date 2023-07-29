import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justmusic/screens/explanations_screen.dart';
import 'package:justmusic/screens/feed_screen.dart';
import 'package:justmusic/screens/login_screen.dart';
import 'package:justmusic/screens/post_screen.dart';
import 'package:justmusic/screens/profile_screen.dart';
import 'package:justmusic/screens/registration_screen.dart';
import 'package:justmusic/screens/welcome_screen.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';
import 'package:justmusic/view_model/UserViewModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ugly as fuck
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static UserViewModel userViewModel = UserViewModel();
  static MusicViewModel musicViewModel = MusicViewModel();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Paint.enableDithering = true;
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
            routes: {
              '/welcome': (context) => WellcomeScreen(),
              '/feed': (context) => FeedScreen(),
              '/login': (context) => LoginScreen(),
              '/register': (context) => RegistrationScreen(),
              '/post': (context) => PostScreen(),
              '/profile': (context) => ProfileScreen(),
              '/explanation': (context) => ExplanationsScreen(),
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
            home: LoginScreen());
      },
      designSize: Size(390, 844),
    );
  }
}
