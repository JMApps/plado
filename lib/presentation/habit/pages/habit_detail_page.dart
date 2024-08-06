import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/habit_data_state.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../state/rest_times_state.dart';
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
  late int _elapsedDays;
  late int _remainingDays;

  @override
  void initState() {
    super.initState();
    _restRemaininPercentage = Provider.of<RestTimesState>(context, listen: false).restRemainingPercentage(
      startDateTime: widget.habitModel.startDateTime,
      endDateTime: widget.habitModel.endDateTime,
    );

    _elapsedDays = _restRemaininPercentage[AppConstraints.restElapsedDays];
    _remainingDays = _restRemaininPercentage[AppConstraints.restRemainingDays];

    _completedDaysController = PageController(
      initialPage: _elapsedDays,
      viewportFraction: 0.65,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _elapsedDays = _restRemaininPercentage[AppConstraints.restElapsedDays];
    _remainingDays = _restRemaininPercentage[AppConstraints.restRemainingDays];
  }

  @override
  void dispose() {
    _completedDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final habitColor = AppStyles.taskHabitColors[widget.habitModel.habitColorIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habitModel.habitTitle),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                radius: 75,
                lineWidth: 20,
                percent: _restRemaininPercentage[AppConstraints.restElapsedPercentage] / 100,
                header: const Padding(
                  padding: AppStyles.paddingBottom,
                  child: Text(
                    AppStrings.elapsedDays,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                center: Text(
                  '$_elapsedDays',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstraints.fontRobotoSlab,
                  ),
                ),
                footer: Padding(
                  padding: AppStyles.paddingTopMini,
                  child: DateTimeItem(
                    description: AppStrings.start,
                    dateTime: widget.habitModel.startDateTime,
                    dateFormat: AppConstraints.standardTimeFormat,
                  ),
                ),
                progressColor: habitColor,
                backgroundColor: habitColor.withOpacity(0.15),
              ),
              const SizedBox(width: 16),
              CircularPercentIndicator(
                reverse: true,
                circularStrokeCap: CircularStrokeCap.round,
                radius: 75,
                lineWidth: 20,
                percent: _restRemaininPercentage[AppConstraints.restRemainingPercentage] / 100,
                header: const Padding(
                  padding: AppStyles.paddingBottom,
                  child: Text(
                    AppStrings.remainingDays,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                center: Text(
                  '${_remainingDays + 1}',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstraints.fontRobotoSlab,
                  ),
                ),
                footer: Padding(
                  padding: AppStyles.paddingTopMini,
                  child: DateTimeItem(
                    description: AppStrings.end,
                    dateTime: widget.habitModel.endDateTime,
                    dateFormat: AppConstraints.standardTimeFormat,
                  ),
                ),
                progressColor: habitColor,
                backgroundColor: habitColor.withOpacity(0.15),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Consumer<HabitDataState>(
              builder: (BuildContext context, habitDataState, _) {
                return FutureBuilder<List<bool>>(
                  future: habitDataState.completedDays(habitId: widget.habitModel.habitId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<bool> completedDays = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 48),
                          const Text(
                            AppStrings.today,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _completedDaysController,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: GestureDetector(
                                    onTap: _elapsedDays == index ? () {
                                      completedDays[index] = !completedDays[index];
                                      if (completedDays[index]) {
                                        HapticFeedback.vibrate();
                                      }
                                      final completedDaysMap = {
                                        DatabaseValues.dbHabitCompletedDays: jsonEncode(completedDays.map((e) => e ? 1 : 0).toList()),
                                      };
                                      Provider.of<HabitDataState>(context, listen: false).updateHabit(
                                        habitMap: completedDaysMap,
                                        habitId: widget.habitModel.habitId,
                                      );
                                    } : null,
                                    child: Icon(completedDays[index] ? Icons.check_circle_rounded : Icons.circle_outlined,
                                      color: !completedDays[index] ? appColors.inversePrimary : habitColor,
                                      size: 275,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return MainErrorText(
                          errorText: snapshot.error.toString());
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                );
              },
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
