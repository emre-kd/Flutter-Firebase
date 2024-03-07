import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{

  //get collection of data
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  //CREATE
  Future<void> addNote(String   note, ) {
    return  notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });

  }

  //READ

  //UPDATE 

  //DELETE

}