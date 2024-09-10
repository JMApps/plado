import '../../data/models/category_model.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategoriesByPeriod({required int periodIndex, required String orderBy});

  Future<int> createCategory({required CategoryModel categoryModel});

  Future<int> updateCategory({required Map<String, dynamic> categoryMap, required int categoryId});

  Future<int> deleteCategory({required int categoryId});
}
