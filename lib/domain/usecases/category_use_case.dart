import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';
import '../../data/models/category_model.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class CategoryUseCase extends ChangeNotifier {
  final CategoryRepository _categoryRepository;

  CategoryUseCase(this._categoryRepository);

  Future<List<CategoryEntity>> fetchCategoriesByPeriod({required int periodIndex, required String orderBy}) async {
    try {
      return await _categoryRepository.getCategoriesByPeriod(periodIndex: periodIndex, orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> createCategory({required CategoryModel categoryModel}) async {
    try {
      final int createCategory = await _categoryRepository.createCategory(categoryModel: categoryModel);
      emptyNotify();
      return createCategory;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> updateTaskCategory({required Map<String, dynamic> categoryMap, required int categoryId}) async {
    try {
      final int updateCategory = await _categoryRepository.updateCategory(categoryMap: categoryMap, categoryId: categoryId);
      emptyNotify();
      return updateCategory;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> deleteTaskCategory({required int categoryId}) async {
    try {
      final int deleteCategory = await _categoryRepository.deleteCategory(categoryId: categoryId);
      emptyNotify();
      return deleteCategory;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<void> emptyNotify() async {
    notifyListeners();
  }
}
