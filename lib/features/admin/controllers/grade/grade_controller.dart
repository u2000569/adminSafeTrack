import 'package:adminpickready/data/abstract/base_data_table_controller.dart';
import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/grades/grade_repository.dart';
import '../category/category_controller.dart';

class GradeController extends SBaseController<GradeModel> {
  static GradeController get instance => Get.find();

  final _gradeRepository = Get.put(GradeRepository());
  final categoryController = Get.put(CategoryController());

  @override
  Future<List<GradeModel>> fetchItems() async{
    try {
      // Fetch grade
    final fetchedGrades = await _gradeRepository.getAllGrade();
    print('Fetched Grades: $fetchedGrades'); // Log to verify data

    for (var grade in fetchedGrades) {
      print('Grades: ${grade.id}, ${grade.name}');
    }

    // Fetch Grade Categories Relational Data
    final fetchedGradeCategories = await _gradeRepository.getAllGradeCategories();

    // Fetch All Categories is data does not already exist
    if(categoryController.allItems.isNotEmpty) await categoryController.fetchItems();

    // Loop all grade and fetch categories of each
    for (var grade in fetchedGrades){
      // Extract categoryIds from documents
      List<String> categoryIds = fetchedGradeCategories
          .where((gradeCategory) => gradeCategory.gradeId == grade.id)
          .map((gradeCategory) => gradeCategory.categoryId)
          .toList();

      grade.gradeCategories = categoryController.allItems.where((category) => categoryIds.contains(category.id)).toList();
    }

    return fetchedGrades;
    } catch (e) {
      print('Error in fetchItems: $e');
      rethrow; // Rethrow to let `fetchData` handle it
    }
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (GradeModel b) => b.name.toLowerCase());
  }

  @override
  bool containsSearchQuery(GradeModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(GradeModel item) async {
    await _gradeRepository.deleteGrade(item);
  }
}