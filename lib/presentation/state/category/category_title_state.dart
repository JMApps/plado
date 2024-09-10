import 'package:flutter/material.dart';

class CategoryTitleState extends ChangeNotifier {
  CategoryTitleState([String categoryTitle = '']) : _categoryTitle = categoryTitle;

  late String _categoryTitle;

  String get getCategoryTitle => _categoryTitle;

  set setCategoryTitle(String categoryTitle) {
    _categoryTitle = categoryTitle;
    notifyListeners();
  }
}