import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../models/student_model.dart';

class DashboardController extends SBaseController<StudentModel>{ //OrderMOdel = StudentModel
  static DashboardController get instance => Get.find();

  final studentController = Get.put(StudentController());
  final RxMap<StudentStatus, int> studentStatusData = <StudentStatus, int>{}.obs;
  final RxMap<StudentStatus, double> totalStudent = <StudentStatus, double>{}.obs;

  final gradeController = Get.put(GradeController());
  final RxMap<String, int> gradeData = <String, int>{}.obs;

  @override
  Future<List<StudentModel>> fetchItems() async{
    // Fetch Students if empty
    if(studentController.allItems.isEmpty){
      await studentController.fetchItems();
    }

    // calculate Student status count
  _calculateStudentStatusData();

  return studentController.allItems;
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
      // totalStudent[status] = (totalStudent[status] ?? 0) + student.totalStudent;
    }
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