import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ParentRepository extends GetxController {
  static ParentRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createParent(UserModel parent) async{
    try {
      await _db.collection("Parent").doc(parent.id).set(parent.toJson());
    } on FirebaseAuthException catch(e){
      throw SFirebaseAuthException(e.code).message;
    } on FormatException catch (_){
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. Cannot save parent data in firestore';
    }
  }

  /// Function to fetch parent details based on parent ID
  Future<List<UserModel>> getAllParent() async{
    try {
      final parentSnapshot = await _db.collection('Parent').get();
      return parentSnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something Went Wrong to fetch Parent Info: $e');
      throw 'Something Went Wrong: $e';
    }
  }

  Future<void> deleteParent(String id) async{
    try {
      await _db.collection("Parent").doc(id).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}