import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../state/habit/habit_item_state.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isNight = theme.brightness == Brightness.dark ? true : false;
    final Color habitColor = AppStyles.taskHabitColors[habitModel.habitColorIndex].withOpacity(isNight ? 0.5 : 1);
    final List<dynamic> jsonList = jsonDecode(habitModel.completedDays);
    final List<bool> completedDays = jsonList.map((e) => e == 0).toList();
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: Consumer<HabitItemState>(
        builder: (context, habitItemState, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                habitModel.habitTitle,
                style: TextStyle(
                  color: habitColor,
                  fontSize: 17,
                ),
              ),
              Text(
                DateFormat('d.M.yyyy H:mm').format(DateTime.parse(habitModel.createDateTime)),
                style: const TextStyle(
                  fontFamily: 'Roboto Slab',
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: completedDays.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CircleAvatar(
                      backgroundColor: habitColor,
                      child: Text('${index + 1}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
