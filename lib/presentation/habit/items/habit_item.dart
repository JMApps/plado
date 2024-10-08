import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    required this.habitIndex,
  });

  final HabitEntity habitModel;
  final int habitIndex;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appTheme = Theme.of(context);
    final String timeAgo = timeago.format(habitModel.createDateTime, locale: appLocale.localeName);
    final habitColor = AppStyles.appColorList[habitModel.habitColorIndex].withOpacity(appTheme.brightness == Brightness.dark ? 0.5 : 1);
    final restRemaininPercentage = Provider.of<RestTimesState>(context).restRemainingPercentage(startDateTime: habitModel.startDateTime, endDateTime: habitModel.endDateTime);
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: ListTile(
        shape: AppStyles.shape,
        onTap: () {
          Navigator.pushNamed(
            context,
            NameRoutes.habitDetailPage,
            arguments: HabitModelArgs(habitModel: habitModel),
          );
        },
        title: Text(
          habitModel.habitTitle,
          style: AppStyles.mainTextBold,
        ),
        subtitle: Text(
          timeAgo,
          style: AppStyles.mainTextRoboto12,
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              NameRoutes.updateHabitPage,
              arguments: HabitModelArgs(habitModel: habitModel),
            );
          },
          icon: const Icon(
            Icons.edit,
          ),
        ),
        leading: Stack(
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
                fontSize: 16,
                fontFamily: AppConstraints.fontRobotoSlab,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
