// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutterfirebase/global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome Home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ), // Added closing parenthesis

          SizedBox(height: 30), // Removed unnecessary comma

          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
              showToast(message: "Signed out");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
