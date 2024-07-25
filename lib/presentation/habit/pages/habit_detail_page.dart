import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../domain/entities/habit_entity.dart';

class HabitDetailPage extends StatelessWidget {
  const HabitDetailPage({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> jsonList = jsonDecode(habitModel.completedDays);
    final List<bool> completedDays = jsonList.map((e) => e == 0).toList();
    return const Placeholder();
  }
}
