import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/usecases/habit_use_case.dart';
import '../../habit/widgets/date_time_item.dart';
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
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    final habitColor = AppStyles.appColorList[widget.habitModel.habitColorIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.habits),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 0,
              margin: AppStyles.paddingMini,
              child: Container(
                alignment: Alignment.center,
                padding: AppStyles.padding,
                child: Text(
                  widget.habitModel.habitTitle,
                  style: AppStyles.mainTextBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 75,
                  lineWidth: 17.5,
                  percent: _restRemaininPercentage[AppConstraints.restElapsedPercentage] / 100,
                  header: Padding(
                    padding: AppStyles.paddingBottom,
                    child: Text(
                      appLocale.elapsedDays,
                      style: AppStyles.mainText,
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
                      description: appLocale.start,
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
                  lineWidth: 17.5,
                  percent: _restRemaininPercentage[AppConstraints.restRemainingPercentage] / 100,
                  header: Padding(
                    padding: AppStyles.paddingBottom,
                    child: Text(
                      appLocale.remainingDays,
                      style: AppStyles.mainText,
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
                      description: appLocale.end,
                      dateTime: widget.habitModel.endDateTime,
                      dateFormat: AppConstraints.dateFormat,
                    ),
                  ),
                  progressColor: habitColor,
                  backgroundColor: habitColor.withOpacity(0.15),
                ),
              ],
            ),
            Consumer<HabitUseCase>(
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
                          Text(
                            widget.habitModel.endDateTime.isAfter(DateTime.now()) ? appLocale.inProgress : appLocale.completed,
                            style: AppStyles.mainTextBold20,
                          ),
                          const SizedBox(height: 8),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
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
          ],
        ),
      ),
    );
  }
}
