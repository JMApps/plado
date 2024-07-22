import 'package:flutter/material.dart';

class TaskRemindState extends ChangeNotifier {
  TaskRemindState([bool isRemind = false]) : _isRemind = isRemind;

  late bool _isRemind;

  bool get getIsRemind => _isRemind;

  set setIsRemind(bool isRemind) {
    _isRemind = isRemind;
    notifyListeners();
  }
}