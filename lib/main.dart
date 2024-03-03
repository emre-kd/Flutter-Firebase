// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/features/user_auth/presentation/pages/login_page.dart';
import 'features/app/splash_screen/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Platform.isAndroid 
  ? await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD51Cy9MYBbYqyPf6CxfdQbMztWxqsEX4s",
      appId: "1:629360165632:android:402a74ecb786b21d66a9e5",
      messagingSenderId: "629360165632",
      projectId: "fluttter-auth-83789",
    ))
  : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
     home: SplashScreen(
      child: LoginPage(),
      )
    );
  }
}
