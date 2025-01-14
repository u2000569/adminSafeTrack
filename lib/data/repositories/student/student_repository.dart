import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/utils/exceptions/firebase_exceptions.dart';
import 'package:adminpickready/utils/exceptions/format_exceptions.dart';
import 'package:adminpickready/utils/exceptions/platform_exceptions.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StudentRepository extends GetxController {
  // Singleton instance of the StudentRepository
  static StudentRepository get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /*-----------------------------FUNCTIONS-------------------------*/

  // Get all students related to the current user
  Future<List<StudentModel>> getAllStudents() async{
    try {
      final result = await _db.collection('Students').orderBy('attendanceDate', descending: true).get(const GetOptions(source: Source.server));
      return result.docs.map((documentSnaphot) => StudentModel.fromSnapshot(documentSnaphot)).toList();
    } on FirebaseException catch(e){
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Create a new student info
  /// Clash with Order_Repo, so need to check back
  /// Maybe need the order are same function where I can assign to student to their parent/teacher
  Future addStudent(StudentModel student) async {
    try {
      // await _db.collection('Students').add(order.toJson());
      final result = await _db.collection('Students').add(student.toJson());
      SLoggerHelper.info('Student ID added: ${result.id}');
      return result.id;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addChildToParent(String parentId, String studentId) async{
    try {
      final parent = await _db.collection('Parent').doc(parentId).collection('Children').doc(parentId).set({
        'Children': FieldValue.arrayUnion([studentId])
      });
      SLoggerHelper.info('Added Student to Parent: $parentId');
      return parent;
    } catch (e) {
      SLoggerHelper.error('Error adding Student to Parent: $e');
    }
  }

  // Update student info
  Future<void> updateStudent(StudentModel student) async{
    try {
      await _db.collection('Students').doc(student.docId).update(student.toJson());
      SLoggerHelper.info('Updated Student: ${student.docId}');
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update student status
  Future<void> updateStudentStatus(String studentId, Map<String, dynamic> data) async{
    try {
      await _db.collection('Students').doc(studentId).update(data);
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await _db.collection("Students").doc(studentId).delete();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  
}