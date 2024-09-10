import '../../core/strings/database_values.dart';

class CategoryModel {
  final int categoryId;
  final String categoryTitle;
  final int categoryColorIndex;
  final int categoryPeriodIndex;

  CategoryModel({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColorIndex,
    required this.categoryPeriodIndex,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map[DatabaseValues.dbCategoryId] as int,
      categoryTitle: map[DatabaseValues.dbCategoryTitle] as String,
      categoryColorIndex: map[DatabaseValues.dbCategoryColorIndex] as int,
      categoryPeriodIndex: map[DatabaseValues.dbCategoryPeriodIndex] as int,
    );
  }

  Map<String, dynamic> categoryToMap() {
    return {
      DatabaseValues.dbCategoryTitle: categoryTitle,
      DatabaseValues.dbCategoryColorIndex: categoryColorIndex,
      DatabaseValues.dbCategoryPeriodIndex: categoryPeriodIndex,
    };
  }
}
