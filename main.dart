import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/chat_page.dart';
import 'pages/gifts_page.dart';
import 'pages/profile_page.dart';
import 'pages/vip_page.dart';
import 'pages/video_page.dart';
import 'pages/live_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IMingle",
      theme: ThemeData(primarySwatch: Colors.blue),

      home: SplashPage(),

      routes: {
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/chat": (context) => ChatPage(),
        "/gifts": (context) => GiftsPage(),
        "/profile": (context) => ProfilePage(),
        "/vip": (context) => VipPage(),
        "/video": (context) => VideoPage(),
        "/live": (context) => LivePage(),
      },
    );
  }
}