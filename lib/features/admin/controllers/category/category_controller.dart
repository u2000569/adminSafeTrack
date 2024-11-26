import 'package:adminpickready/data/abstract/base_data_table_controller.dart';
import 'package:adminpickready/data/repositories/categories/category_repository.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';

class CategoryController extends SBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id);
  }

   @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  /// Sorting related code
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (CategoryModel category) => category.name.toLowerCase());
  }
}