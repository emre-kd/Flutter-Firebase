// ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutterfirebase/features/user_auth/presentation/services/firestore.dart';
// import 'package:flutterfirebase/features/user_auth/presentation/pages/login_page.dart';
// import 'package:flutterfirebase/global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //open a input

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FireStoreService fireStoreService = FireStoreService();

  //text Controller
  final TextEditingController textConroller = TextEditingController();

  void openInput() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textConroller,
        ),
        actions: [
          //button to save
          ElevatedButton(
            onPressed: () {
              //add new note
              fireStoreService.addNote(textConroller.text);
              //clear the text controller
              textConroller.clear();
              //close the box
              Navigator.pop(context);

            }, 
            child: Text("Add"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To do list",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(113, 82, 76, 1),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 58.0),
        child: FloatingActionButton(
          onPressed: openInput,
          child: const Icon(
            Icons.add,
            color: Colors.white70,
          ),
          backgroundColor: Colors.black,
        ),
      ),
      body: Column(

          /*
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
 

          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
              showToast(message: "Signed out");
            },
        
              child: Center(
                child: Container(
                  
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 2, 14, 24),
                   
                  ),
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
         
          ),
        ], */
          ),
    );
  }
}
