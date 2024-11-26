import 'package:adminpickready/models/newuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  //collectionn reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');

  //From User Collection
  // Future<void> updateSingleData(
  //   CollectionSelector selector, String value) async{
  //     if (selector == CollectionSelector.name) {
  //       await userCollection.doc(uid).update({
  //         'Full Name': value,
  //       });
        
  //     }else if(selector == CollectionSelector.email){
  //       await userCollection.doc(uid).update({
  //         'Email' :value
  //       });
  //     }else if(selector == CollectionSelector.phoneNumber){
  //       await userCollection.doc(uid).update({
  //         'Phone Number' : value
  //       });
  //     }else{
        
  //     }
  //   } 

    //NewUserData from snapshot aka single data of specific user
  NewUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return NewUserData(
      uid: uid,
      fullName: snapshot['fullName'],
      phoneNumber: snapshot['phoneNumber'],
      email: snapshot['email'],
      role: snapshot['role']
    );
  }
  
    Future<DocumentSnapshot<Object?>>? getNewUserDataSnapshot(User? user) {
    if (user == null) return null;
    return userCollection.doc(user.uid).get();
  }
  
  //new user register  
   Future updateUserData(String fullname, String phoneNumber, String email, String role )async{
    await userCollection.doc(uid).set({
      'uid' : uid,
      'fullName': fullname,
      'email': email,
      'phoneNumber': phoneNumber,
      'role' : role,
    }).then((_){
      print("Success!");
    });
  }
}