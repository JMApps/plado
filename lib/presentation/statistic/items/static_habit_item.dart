import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/habit_model_args.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../state/rest_times_state.dart';

class StaticHabitItem extends StatelessWidget {
  const StaticHabitItem({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final habitColor = AppStyles.taskHabitColors[habitModel.habitColorIndex].withOpacity(appTheme.brightness == Brightness.dark ? 0.5 : 1);
    final restRemaininPercentage = Provider.of<RestTimesState>(context).restRemainingPercentage(startDateTime: habitModel.startDateTime, endDateTime: habitModel.endDateTime);
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            NameRoutes.habitStaticDetailPage,
            arguments: HabitModelArgs(
              habitModel: habitModel,
            ),
          );
        },
        shape: AppStyles.shape,
        title: Text(habitModel.habitTitle),
        leading: CircleAvatar(
          backgroundColor: appTheme.colorScheme.onSecondary,
          child: Text(
            habitModel.habitId.toString(),
            style: const TextStyle(
              fontFamily: AppConstraints.fontRobotoSlab,
            ),
          ),
        ),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CircularProgressIndicator(
                color: habitColor,
                strokeCap: StrokeCap.round,
                value: restRemaininPercentage[AppConstraints.restRemainingPercentage] / 100,
              ),
            ),
            Text(
              (restRemaininPercentage[AppConstraints.restRemainingDays] + 1).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: AppConstraints.fontRobotoSlab,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
