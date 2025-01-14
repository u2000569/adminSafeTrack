import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/admin/models/attendance_model.dart';
import '../../../utils/logging/logger.dart';

class AttendanceRepository extends GetxController {
  static AttendanceRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /*----------------------Save Attendance Student----------------------*/
  Future<void> saveAttendanceStudent(DateTime date, String docIdAttd, AttendanceModel attendance) async{
    try {
      // Create a new DateTime instance with only year, month, and day
      final formattedDate = DateTime(date.year, date.month, date.day);

      final dateKey = formattedDate.toIso8601String().split('T').first;

      await _db.collection('Attendance').doc(dateKey)
        .collection('studentsRecords').doc(docIdAttd)
        .set(attendance.toJson());
      SLoggerHelper.info('Attendance on $dateKey saved successfully');
    } catch (e) {
      SLoggerHelper.error('Error saving attendance: $e');
    }
  }

  /*----------------------Update Attendance Student----------------------*/
  Future<void> updateAttendanceStudent(DateTime date, String docIdAttd, Map<String, dynamic> json) async{
    try {
      // Create a new DateTime instance with only year, month, and day
      final formattedDate = DateTime(date.year, date.month, date.day);

      final dateKey = formattedDate.toIso8601String().split('T').first;

      await _db.collection('Attendance').doc(dateKey)
          .collection('studentsRecords').doc(docIdAttd)
          .update(json);
      SLoggerHelper.info('Attendance on $dateKey updated successfully');
    } catch (e) {
      SLoggerHelper.error('Error updating attendance: $e');
    }
  }

  /*----------------------Get All Attendance Records----------------------*/
  Future<List<AttendanceModel>> getAllAttendanceRecords() async {
    List<AttendanceModel> allRecords = [];
    try {
      final dateDocs = await _db.collection('Attendance').get();

      if (dateDocs.docs.isEmpty) {
      SLoggerHelper.warning('No attendance documents found in Firestore.');
      return [];
      }

      for (var dateDoc in dateDocs.docs) {
        SLoggerHelper.info('Found date document: ${dateDoc.id}');
        final studentRecords = await _db.collection('Attendance')
            .doc(dateDoc.id)
            .collection('studentsRecords')
            .get();
      
        if (studentRecords.docs.isEmpty) {
          SLoggerHelper.info('No student records found for date: ${dateDoc.id}');
          continue;
        }

        allRecords.addAll(studentRecords.docs.map((doc) {
            return AttendanceModel.fromMap(doc.data());
        }));
      }
      return allRecords;
    } catch (e) {
      SLoggerHelper.error('Error retrieving all attendance records: $e');
      return [];
    }
  }

  /*----------------------Get Attendance for Specific Date----------------------*/
  Future<List<AttendanceModel>> getAttendanceByDate(DateTime date) async {
    try {
      final dateKey = _formatDate(date);

      final querySnapshot = await _db.collection('Attendance')
          .doc(dateKey)
          .collection('studentsRecords')
          .get();

      return querySnapshot.docs.map((doc) {
        return AttendanceModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      SLoggerHelper.error('Error retrieving attendance for date $date: $e');
      return [];
    }
  }

  /*----------------------Get Specific Student Attendance Record----------------------*/
  Future<List<AttendanceModel>> getAttendanceForStudent(String studentId) async {
    try {
      final querySnapshot = await _db.collectionGroup('studentsRecords')
          .where(FieldPath.documentId, isEqualTo: studentId)
          .get();

      return querySnapshot.docs.map((doc) {
        return AttendanceModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      SLoggerHelper.error('Error retrieving attendance for student $studentId: $e');
      return [];
    }
  }

  /*----------------------Helper Function to Format Date----------------------*/
  String _formatDate(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .toIso8601String()
        .split('T')
        .first;
  }

}