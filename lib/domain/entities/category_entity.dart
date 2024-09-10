import '../../data/models/category_model.dart';

class CategoryEntity {
  final int categoryId;
  final String categoryTitle;
  final int categoryColorIndex;
  final int categoryPeriodIndex;

  CategoryEntity({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColorIndex,
    required this.categoryPeriodIndex,
  });

  factory CategoryEntity.fromModel(CategoryModel categoryModel) {
    return CategoryEntity(
      categoryId: categoryModel.categoryId,
      categoryTitle: categoryModel.categoryTitle,
      categoryColorIndex: categoryModel.categoryColorIndex,
      categoryPeriodIndex: categoryModel.categoryPeriodIndex,
    );
  }
}
