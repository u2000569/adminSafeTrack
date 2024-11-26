import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:adminpickready/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:adminpickready/utils/exceptions/format_exceptions.dart';
import 'package:adminpickready/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TeacherRepository extends GetxController {
  // Singleton instance of the TeacherRepository
  static TeacherRepository get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> createTeacher(UserModel teacher) async{
    try {
      await _db.collection("Teacher").doc(teacher.id).set(teacher.toJson());
    } on FirebaseAuthException catch(e){
      throw SFirebaseAuthException(e.code).message;
    } on FormatException catch (_){
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. Cannot save teacher data in firestore';
    }
  }

  /// Function to fetch teacher details based on teacher ID
  Future<List<UserModel>> getTeacher() async{
    try {
      final teacherSnapshot = await _db.collection('Teacher').get();
      return teacherSnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something Went Wrong to fetch Teacher Info: $e');
      throw 'Something Went Wrong: $e';
    }
  }

  Future<void> deleteUser(String id) async{
    try {
      await _db.collection("Teacher").doc(id).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  
}