import '../../data/models/category_model.dart';

class CategoryEntity {
  final int categoryId;
  final String categoryTitle;
  final int categoryColorIndex;
  final int categoryPeriodIndex;
  final DateTime startDateTime;
  final DateTime endDateTime;

  CategoryEntity({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColorIndex,
    required this.categoryPeriodIndex,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory CategoryEntity.fromModel(CategoryModel categoryModel) {
    return CategoryEntity(
      categoryId: categoryModel.categoryId,
      categoryTitle: categoryModel.categoryTitle,
      categoryColorIndex: categoryModel.categoryColorIndex,
      categoryPeriodIndex: categoryModel.categoryPeriodIndex,
      startDateTime: categoryModel.startDateTime,
      endDateTime: categoryModel.endDateTime,
    );
  }
}
