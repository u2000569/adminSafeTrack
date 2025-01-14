import 'package:adminpickready/data/abstract/base_data_table_controller.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/parent/parent_repository.dart';
import '../../../personalization/models/user_model.dart';

class ParentController extends SBaseController<UserModel> {
  static ParentController get instance => Get.find();

  final _parentRepository = Get.put(ParentRepository());

  @override 
  Future<List<UserModel>> fetchItems() async{
    try {
      // Fetch parent
    final fetcParent = await _parentRepository.getAllParent();
    SLoggerHelper.info('Fetch Parent: $fetcParent'); // Log to verify data

    for(var parent in fetcParent){
      SLoggerHelper.info('Parent: ${parent.id}, ${parent.fullName}');
    }
    return fetcParent;
    } catch (e) {
      SLoggerHelper.error('Error in fetchParent: $e');
      rethrow; // Rethrow to let `fetchData` handle it
    }
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