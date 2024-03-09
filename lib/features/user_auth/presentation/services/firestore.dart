
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{

  //get collection of data
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  //CREATE
  Future<void> addNote(String   note, String userId,  String userEmail ) {
    return  notes.add({
      'note': note,
      'userEmail': userEmail,
      'userId': userId,
      'timestamp': Timestamp.now(),
    });

  }

  //READ
  Stream<QuerySnapshot> getNotesStream() {
     final notesStream = FirebaseFirestore.instance
      .collection('notes') // Replace 'your_collection_name' with your actual collection name
      .where('userId', isEqualTo: '8pcJBq9efMRQByYv2zgdJJiZcjB2')
      .orderBy('timestamp', descending: true)
      .snapshots();

  return notesStream;
  }

  //UPDATE 
  Future<void> updateNote(String docID, String newNote) {

    return notes.doc(docID).update({
      'note': newNote,
      
    });
  }

  //DELETE

   Future<void> deleteNote(String docID) {

   return notes.doc(docID).delete();
  }


}