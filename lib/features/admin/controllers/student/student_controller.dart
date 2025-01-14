import 'package:adminpickready/data/abstract/base_data_table_controller.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../data/repositories/student/student_repository.dart';

class StudentController extends SBaseController<StudentModel>{
  static StudentController get instance => Get.find();

  RxList<StudentModel> filteredItems = <StudentModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

  RxBool statusLoader = false.obs;
  var studentStatus = StudentStatus.present.obs;
  final _studentRepository = Get.put(StudentRepository());

  // Method to refresh the list
  void updateStudentInList(StudentModel updatedStudent) {
    int index = filteredItems.indexWhere((student) => student.id == updatedStudent.id);
    if (index == -1) {
      SLoggerHelper.error('Student ${updatedStudent.id} not found in list');
    }
    filteredItems[index] = updatedStudent;
    filteredItems.refresh(); // Notify listeners
  }

  @override
  Future<List<StudentModel>> fetchItems() async{
    sortAscending.value = false;
    
    return await _studentRepository.getAllStudents();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (StudentModel o) => o.docId.toString().toLowerCase());
  }

  /// Sorting related code
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (StudentModel student) => student.name.toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (StudentModel o) => o.attendanceDate.toString().toLowerCase());
  }

  @override
  bool containsSearchQuery(StudentModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(StudentModel item) async {
    await _studentRepository.deleteStudent(item.docId);
  }

  // Update Student Status
  Future<void> updateStudentStatus(StudentModel student, StudentStatus newStatus) async{
    try {
      statusLoader.value = true;
      student.status = newStatus;
      await _studentRepository.updateStudentStatus(student.docId, {'status': newStatus.toString()});
      updateItemFromLists(student);
      studentStatus.value = newStatus;
      SLoaders.successSnackBar(title: 'Updated', message: 'Student Status Updated');

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to update student status', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  } 
}