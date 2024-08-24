import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/habit_data_state.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../habit/items/date_time_item.dart';
import '../../state/rest_times_state.dart';
import '../../widgets/main_error_text.dart';

class HabitStaticDetailPage extends StatefulWidget {
  const HabitStaticDetailPage({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  State<HabitStaticDetailPage> createState() => _HabitStaticDetailPageState();
}

class _HabitStaticDetailPageState extends State<HabitStaticDetailPage> {
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
                    dateFormat: AppConstraints.dateFormat,
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
                    dateFormat: AppConstraints.dateFormat,
                  ),
                ),
                progressColor: habitColor,
                backgroundColor: habitColor.withOpacity(0.15),
              ),
            ],
          ),
          Expanded(
            child: Consumer<HabitDataState>(
              builder: (BuildContext context, habitDataState, _) {
                return FutureBuilder<List<bool>>(
                  future: habitDataState.completedDays(
                    habitId: widget.habitModel.habitId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<bool> completedDays = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            AppStrings.allDays,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: GridView.builder(
                              padding: AppStyles.paddingMini,
                              itemCount: completedDays.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppStyles.border,
                                    side: BorderSide(
                                      width: 2.5,
                                      color: index == _elapsedDays ? appColors.onTertiaryContainer : Colors.transparent,
                                    )
                                  ),
                                  color: completedDays[index] ? habitColor : index < _elapsedDays ? appColors.surfaceContainerHigh : appColors.inversePrimary,
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppConstraints.fontRobotoSlab,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return MainErrorText(
                        errorText: snapshot.error.toString(),
                      );
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
        ],
      ),
    );
  }
}
