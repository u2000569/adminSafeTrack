import 'package:adminpickready/data/abstract/base_data_table_controller.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/parent/parent_repository.dart';
import '../../../personalization/models/user_model.dart';

class ParentController extends SBaseController<UserModel> {
  static ParentController get instance => Get.find();

  final _parentRepository = Get.put(ParentRepository());

  @override 
  Future<List<UserModel>> fetchItems() async{
    // Fetch parent
    return await _parentRepository.getAllParent();
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
    await _parentRepository.deleteParent(item.id ?? '');
  }
}