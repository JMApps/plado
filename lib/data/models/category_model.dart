import '../../core/strings/database_values.dart';

class CategoryModel {
  final int categoryId;
  final String categoryTitle;
  final int categoryColorIndex;
  final int categoryPeriodIndex;
  final DateTime startDateTime;
  final DateTime endDateTime;

  CategoryModel({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColorIndex,
    required this.categoryPeriodIndex,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map[DatabaseValues.dbCategoryId] as int,
      categoryTitle: map[DatabaseValues.dbCategoryTitle] as String,
      categoryColorIndex: map[DatabaseValues.dbCategoryColorIndex] as int,
      categoryPeriodIndex: map[DatabaseValues.dbCategoryPeriodIndex] as int,
      startDateTime: DateTime.parse(map[DatabaseValues.dbCategoryStartDateTime]),
      endDateTime: DateTime.parse(map[DatabaseValues.dbCategoryEndDateTime]),
    );
  }

  Map<String, dynamic> categoryToMap() {
    return {
      DatabaseValues.dbCategoryTitle: categoryTitle,
      DatabaseValues.dbCategoryColorIndex: categoryColorIndex,
      DatabaseValues.dbCategoryPeriodIndex: categoryPeriodIndex,
      DatabaseValues.dbCategoryStartDateTime: startDateTime.toIso8601String(),
      DatabaseValues.dbCategoryEndDateTime: endDateTime.toIso8601String(),
    };
  }
}
