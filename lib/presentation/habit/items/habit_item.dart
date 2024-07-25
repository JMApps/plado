import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/habit_model_args.dart';
import '../../../domain/entities/habit_entity.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    final String timeAgo = timeago.format(DateTime.parse(habitModel.createDateTime), locale: 'en');
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, NameRoutes.habitDetailPage, arguments: HabitModelArgs(habitEntity: habitModel));
        },
        shape: AppStyles.shapeMini,
        title: Text(
          habitModel.habitTitle,
          style: const TextStyle(fontSize: 17),
        ),
        subtitle: Text(
          '${AppStrings.added} $timeAgo',
          style: const TextStyle(
            fontFamily: 'Roboto Slab',
          ),
        ),
        trailing: CircleAvatar(
          child: Text(
            AppStyles.habitPeriodDayList[habitModel.habitPeriodIndex].toString(),
          ),
        ),
      ),
    );
  }
}
