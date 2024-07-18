import 'package:flutter/material.dart';

import '../../../domain/entities/habit_entity.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
