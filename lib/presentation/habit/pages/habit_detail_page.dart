import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/habit_data_state.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../state/rest_times_state.dart';
import '../../task/widgets/text_description.dart';
import '../../widgets/main_error_text.dart';
import '../items/date_time_item.dart';

class HabitDetailPage extends StatefulWidget {
  const HabitDetailPage({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  State<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  late final PageController _completedDaysController;
  late final Map<String, dynamic> _restRemaininPercentage;

  @override
  Widget build(BuildContext context) {
    final habitColor = AppStyles.taskHabitColors[widget.habitModel.habitColorIndex];
    final appColors = Theme.of(context).colorScheme;
    _restRemaininPercentage = Provider.of<RestTimesState>(context).restRemainingPercentage(
      startDateTime: widget.habitModel.startDateTime,
      endDateTime: widget.habitModel.endDateTime,
    );
    final int initialPage = (_restRemaininPercentage[AppConstraints.restElapsedDays] ?? 0);
    _completedDaysController = PageController(initialPage: initialPage, viewportFraction: 0.75);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habitModel.habitTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: AppStyles.paddingHorizontal,
              child: Card(
                child: Container(
                  padding: AppStyles.padding,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      DateTimeItem(
                        description: AppStrings.added,
                        dateTime: widget.habitModel.createDateTime,
                        dateFormat: 'd.M.yyyy / h:m',
                        color: appColors.onSurface,
                      ),
                      const SizedBox(height: 8),
                      const TextDescription(text: AppStrings.remainingDays),
                      const SizedBox(height: 8),
                      CircularPercentIndicator(
                        reverse: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: 75,
                        lineWidth: 20,
                        percent: _restRemaininPercentage[AppConstraints.restElapsedPercentage] / 100,
                        center: Text(
                          '${_restRemaininPercentage[AppConstraints.restRemainingDays] + 1}',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstraints.fontRobotoSlab,
                          ),
                        ),
                        progressColor: habitColor,
                        backgroundColor: habitColor.withOpacity(0.15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: AppStyles.paddingHorizontal,
              child: Card(
                child: Padding(
                  padding: AppStyles.paddingHorVerMini,
                  child: DateTimeItem(
                    description: AppStrings.start,
                    dateTime: widget.habitModel.startDateTime,
                    dateFormat: 'd.M.yyyy',
                    color: appColors.primary,
                  ),
                ),
              ),
            ),
            Consumer<HabitDataState>(
              builder: (BuildContext context, habitDataState, _) {
                return FutureBuilder<List<bool>>(
                  future: habitDataState.completedDays(habitId: widget.habitModel.habitId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 250,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _completedDaysController,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final List<bool> completedDays = snapshot.data!;
                            return Card(
                              child: Container(
                                alignment: Alignment.center,
                                padding: AppStyles.padding,
                                child: IconButton(
                                  onPressed: () {
                                    completedDays[index] = !completedDays[index];
                                    if (completedDays[index]) {
                                      HapticFeedback.vibrate();
                                    }
                                    final completedDaysMap = {
                                      DatabaseValues.dbHabitCompletedDays:
                                      jsonEncode(completedDays.map((e) => e ? 1 : 0).toList()),
                                    };
                                    Provider.of<HabitDataState>(context, listen: false).updateHabit(
                                      habitMap: completedDaysMap,
                                      habitId: widget.habitModel.habitId,
                                    );
                                  },
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      completedDays[index] ? Icons.check_circle_rounded : Icons.circle_outlined,
                                      key: ValueKey<bool>(completedDays[index]),
                                      color: appColors.secondary,
                                      size: 175,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return MainErrorText(errorText: snapshot.error.toString());
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                );
              },
            ),
            Padding(
              padding: AppStyles.paddingHorizontal,
              child: Card(
                child: Padding(
                  padding: AppStyles.paddingHorVerMini,
                  child: DateTimeItem(
                    description: AppStrings.end,
                    dateTime: widget.habitModel.endDateTime,
                    dateFormat: 'd.M.yyyy',
                    color: appColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
