import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_model.dart';
import '../services/plado_database_service.dart';

class CategoryDataRepository implements CategoryRepository {
  final PladoDatabaseService _pladoDatabaseService;

  CategoryDataRepository(this._pladoDatabaseService);

  @override
  Future<List<CategoryEntity>> getCategoriesByPeriod({required int periodIndex, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbCategoryTableName, where: '${DatabaseValues.dbCategoryPeriodIndex} = ?', whereArgs: [periodIndex], orderBy: orderBy);
    final List<CategoryEntity> taskCategoriesByPeriod = resources.isNotEmpty ? resources.map((e) => CategoryEntity.fromModel(CategoryModel.fromMap(e))).toList() : [];
    return taskCategoriesByPeriod;
  }

  @override
  Future<int> createCategory({required CategoryModel categoryModel}) async {
    final Database database = await _pladoDatabaseService.db;
    return await database.insert(DatabaseValues.dbCategoryTableName, categoryModel.categoryToMap());
  }

  @override
  Future<int> updateCategory({required Map<String, dynamic> categoryMap, required int categoryId}) async {
    final Database database = await _pladoDatabaseService.db;
    return await database.update(DatabaseValues.dbCategoryTableName, categoryMap, where: '${DatabaseValues.dbCategoryId} = ?', whereArgs: [categoryId]);
  }

  @override
  Future<int> deleteCategory({required int categoryId}) async {
    final Database database = await _pladoDatabaseService.db;
    await database.delete(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskSampleBy} = ?', whereArgs: [categoryId]);
    return await database.delete(DatabaseValues.dbCategoryTableName, where: '${DatabaseValues.dbCategoryId} = ?', whereArgs: [categoryId]);
  }
}