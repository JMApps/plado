import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';
import '../../data/models/category_model.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class CategoryUseCase extends ChangeNotifier {
  final CategoryRepository _categoryRepository;

  CategoryUseCase(this._categoryRepository);

  String _errorMessage = '';

  String get getErrorMessage => _errorMessage;

  Future<List<CategoryEntity>> fetchCategoriesByPeriod({required int periodIndex, required String orderBy}) async {
    try {
      return await _categoryRepository.getCategoriesByPeriod(periodIndex: periodIndex, orderBy: orderBy);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> createCategory({required CategoryModel categoryModel}) async {
    try {
      final int createCategory = await _categoryRepository.createCategory(categoryModel: categoryModel);
      notifyListeners();
      return createCategory;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> updateTaskCategory({required Map<String, dynamic> categoryMap, required int categoryId}) async {
    try {
      final int updateCategory = await _categoryRepository.updateCategory(categoryMap: categoryMap, categoryId: categoryId);
      notifyListeners();
      return updateCategory;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> deleteTaskCategory({required int categoryId}) async {
    try {
      final int deleteCategory = await _categoryRepository.deleteCategory(categoryId: categoryId);
      notifyListeners();
      return deleteCategory;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }
}
