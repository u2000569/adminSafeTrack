import 'package:adminpickready/data/repositories/attendance_repository/attendance_repository.dart';
import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../models/student_model.dart';

class DashboardController extends SBaseController<StudentModel>{ //OrderMOdel = StudentModel
  static DashboardController get instance => Get.find();

  final studentController = Get.put(StudentController());
  final RxMap<StudentStatus, int> studentStatusData = <StudentStatus, int>{}.obs;
  final RxMap<StudentStatus, double> totalStudent = <StudentStatus, double>{}.obs;
  final RxList<double> weeklyAttendance = <double>[].obs;

  final gradeController = Get.put(GradeController());
  final RxMap<String, int> gradeData = <String, int>{}.obs;

  final attendanceRepository = Get.put(AttendanceRepository());

  @override
  Future<List<StudentModel>> fetchItems() async{
    // Fetch Students if empty
    if(studentController.allItems.isEmpty){
      await studentController.fetchItems();
    }

    // reset weekly attendance
    weeklyAttendance.value = List<double>.filled(7,0.0);

    // _calculateWeeklyAttendance();

    // calculate weekly attendance
     _calculateWeeklyAttendance2();

    // calculate Student status count
    _calculateStudentStatusData();

  return studentController.allItems;
  }

  void _calculateWeeklyAttendance(){
    for(var student in studentController.allItems){
      SLoggerHelper.info('Student: ${student.name}, Total Amount: ${student.totalAmount}');

      if(student.attendanceDate == null){
        SLoggerHelper.info('Student ${student.name} has no attendance date.');
        continue; // Skip if attendanceDate is null
      }

      final DateTime attendanceWeekStart = SHelperFunctions.getStartOfWeek(student.attendanceDate);

      // check if the student is within the current week
      if(attendanceWeekStart.isBefore(DateTime.now()) 
          && attendanceWeekStart.add(const Duration(days: 7))
          .isAfter(DateTime.now()))
        {
          // Adjust index based on DateTime weekday representation
          int index = (student.attendanceDate.weekday - 1) %7;
          //ensure the index is not -ve
          index = index < 0 ? index + 7 : index;

          SLoggerHelper.info('Attendance Date: ${student.attendanceDate}, Current Week Start: $attendanceWeekStart, Index: $index');

          weeklyAttendance[index] += student.totalAmount;
          // weeklyAttendance.value = [1.0, 2.0, 0.0, 3.0, 0.0, 0.0, 5.0];
 
        }
    }
    SLoggerHelper.info('Weekly Attendance: $weeklyAttendance');
  }

  void _calculateWeeklyAttendance2() async{
    try {
      // fetch all attendance records from repository
    final attendanceRecords = await attendanceRepository.getAllAttendanceRecords();
    SLoggerHelper.info('Attendance Records: ${attendanceRecords.length}');
    // start of the current week
    final weekStart = SHelperFunctions.getStartOfWeek(DateTime.now());
    SLoggerHelper.info('Week Start Date: $weekStart');

    // Iterate through all attendance records
    for(var record in attendanceRecords){
      if(record.checkIn == null) continue;

      // parse the checkIn date
      final DateTime checkInDate = record.checkIn!;
      final DateTime recordWeekStart = SHelperFunctions.getStartOfWeek(checkInDate);

      // check if the record is within the current week
      if(recordWeekStart == weekStart){
        // Adjust index based on DateTime weekday representation
        int index = (checkInDate.weekday - 1) % 7;

        // ensure the index is not -ve
        index = index < 0 ? index + 7 : index;

        // increment the attendance count for the day
        weeklyAttendance[index] += 1.0; // Assuming each record adds one unit to attendance
      }
    }

    SLoggerHelper.info('Weekly Attendance: $weeklyAttendance');
    } catch (e) {
      SLoggerHelper.error('Error calculating weekly attendance: $e');
    }
  }

  void _calculateStudentStatusData(){
    // reset status data
    studentStatusData.clear();

    // Map to store total amounts for each status
    totalStudent.value = {
      for (var status in StudentStatus.values) status: 0.0
    };

    for (var student in studentController.allItems){
      // Update status count
      final StudentStatus status = student.status;
      studentStatusData[status] = (studentStatusData[status] ?? 0) + 1;

      // Calculate total students for each status
      totalStudent[status] = (totalStudent[status] ?? 0) + student.totalAmount;
    }
    SLoggerHelper.info('Stundet Status Data: $studentStatusData');
  }

  String getDisplayStatusName(StudentStatus status) {
    switch (status) {
      case StudentStatus.pending:
        return 'Pending';
      case StudentStatus.present:
        return 'Present';
      case StudentStatus.absent:
        return 'Absent';
      case StudentStatus.excuse:
        return 'Excuse';
      case StudentStatus.sick:
        return 'Sick';
      case StudentStatus.waiting:
        return 'Waiting';
      case StudentStatus.callling:
        return 'Calling';  
      default:
        return 'Unknown';
    }
  }

  Future<List<GradeModel>> fetchGrade() async{
    if(gradeController.allItems.isEmpty){
      await gradeController.fetchItems();
    }

    _calculateGradeData();

    return gradeController.allItems;
  }

  void _calculateGradeData(){
    // reset status data

    gradeData.clear();
    for (var grade in gradeController.allItems) {
      final String gradeName = grade.name;
      gradeData[gradeName] = (gradeData[gradeName] ?? 0) + 1;
    }
  }


  @override
  Future<void> deleteItem(StudentModel item) async{}

  @override
  bool containsSearchQuery(StudentModel item, String query) => false;

  
}