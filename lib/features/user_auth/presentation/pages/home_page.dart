// ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // ignore: non_constant_identifier_names
  late String? userId; // Variable to store the user ID
  late String? userEmail; // Variable to store the user ID
  late String? userDisplayName; // Variable to store the user ID

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  // Function to get the current user's ID
  void _getCurrentUserId() async {
    // Retrieve the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userId = user.uid;
        userEmail = user.email;
      });
    }
  }

  void openInput({String? docID}) {
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
                if (docID == null) {
                  fireStoreService.addNote(
                      textConroller.text, userId!, userEmail!);
                } else {
                  //update existing note if docID is not null
                  fireStoreService.updateNote(docID, textConroller.text);
                }
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
        body: StreamBuilder<QuerySnapshot>(
        stream: getNotesStream(), // Call your function to get the stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while waiting for data
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // If the stream has data
          if (snapshot.hasData) {
            // Extract the list of documents from the snapshot
            final List<DocumentSnapshot> notes = snapshot.data!.docs;


            // Your logic to display the data, for example:
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {

                // Access the fields from the document
                final Map<String, dynamic> data = notes[index].data() as Map<String, dynamic>;
                final String note = data['note'];
                final String userId = data['userId'];
                final String userEmail = data['userEmail'];
                 final String docID = notes[index].id;


                // Display the data in your UI
                    return ListTile(
                        title: Row(
                          children: [
                            Text(note),
                            SizedBox(
                                height:
                                    8), // Add space between the two Text widgets if needed

                            // Display userId with left margin
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                userEmail,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          //Update
                          children: [
                            IconButton(
                              onPressed: () => openInput(docID: docID),
                              icon: const Icon(Icons.edit),
                            ),

                            //Delete
                            IconButton(
                              onPressed: () =>
                                  fireStoreService.deleteNote(docID),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
              },
            );
          }

          return Text('No data available'); // Display a message if there is no data
        },
      ),
    );
  }
  
   Stream<QuerySnapshot> getNotesStream() {
     final notesStream = FirebaseFirestore.instance
      .collection('notes') // Replace 'your_collection_name' with your actual collection name
      .where('userId', isEqualTo: userId)
      .orderBy('timestamp', descending: true)
      .snapshots();

  return notesStream;
  }
}
