import 'package:flutter/material.dart';

import '../../../domain/entities/habit_entity.dart';

class HabitStaticDetailPage extends StatelessWidget {
  const HabitStaticDetailPage({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habitModel.habitTitle),
      ),
      body: Container(),
    );
  }
}
