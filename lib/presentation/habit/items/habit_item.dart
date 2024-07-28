import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/habit_model_args.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../state/rest_times_state.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final String timeAgo = timeago.format(habitModel.createDateTime, locale: 'en');
    final habitColor = AppStyles.taskHabitColors[habitModel.habitColorIndex].withOpacity(appTheme.brightness == Brightness.dark ? 0.5 : 1);
    final restRemaininPercentage = Provider.of<RestTimesState>(context).restRemainingPercentage(startDateTime: habitModel.startDateTime, endDateTime: habitModel.endDateTime);
    final Duration remaininDays = restRemaininPercentage[AppConstraints.restRemainingDateTime];
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            NameRoutes.habitDetailPage,
            arguments: HabitModelArgs(habitModel: habitModel),
          );
        },
        onLongPress: () {
          Navigator.pushNamed(
            context,
            NameRoutes.updateHabitPage,
            arguments: HabitModelArgs(habitModel: habitModel),
          );
        },
        shape: AppStyles.shapeMini,
        title: Text(
          habitModel.habitTitle,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          timeAgo,
          style: const TextStyle(
            fontFamily: AppConstraints.fontRobotoSlab,
          ),
        ),
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
                value: restRemaininPercentage[AppConstraints.restElapsedPercentage] / 100,
              ),
            ),
            Text(
              (remaininDays.inDays + 1).toString(),
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
