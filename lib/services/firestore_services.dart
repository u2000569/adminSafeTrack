import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add student info
  Future<void> addStudentInfo(String info) async {
    try {
      await _db.collection('students').add({'info': info});
    } on FirebaseException catch (e) {
      print('Error adding info: $e');
    }
  }

  // Update existing info
  Future<void> updateInfo(String docID, String info) async {
    try {
      await _db.collection('students').doc(docID).update({'info': info});
    } on FirebaseException catch (e) {
      print('Error updating info: $e');
    }
  }

  // Delete info
  Future<void> deleteInfo(String docID) async {
    try {
      await _db.collection('students').doc(docID).delete();
    } on FirebaseException catch (e) {
      print('Error deleting info: $e');
    }
  }

  // Get stream of student info
  Stream<QuerySnapshot> getInfoStream() {
    try {
      return _db.collection('students').snapshots();
    } on FirebaseException catch (e) {
      print('Error getting info stream: $e');
      throw e; // Re-throw after logging
    }
  }
}
