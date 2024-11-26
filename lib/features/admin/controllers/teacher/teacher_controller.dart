import 'package:adminpickready/data/abstract/base_data_table_controller.dart';
import 'package:adminpickready/data/repositories/teacher/teacher_repository.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

class TeacherController extends SBaseController<UserModel> {
  static TeacherController get instance => Get.find();

  final _teacherRepository = Get.put(TeacherRepository());

  @override
  Future<List<UserModel>> fetchItems() async{
    return await _teacherRepository.getTeacher();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toString().toLowerCase());
  }

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _teacherRepository.deleteUser(item.id ?? '');
  }
}