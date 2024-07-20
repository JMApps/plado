import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/enums/habit_period.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/habit_data_state.dart';
import '../../state/create_habit_state.dart';
import '../../state/rest_times_state.dart';
import '../../widgets/main_back_button.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _habitTextController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void dispose() {
    _habitTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final restTimeState = Provider.of<RestTimesState>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CreateHabitState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.addingHabit),
          leading: const MainBackButton(),
        ),
        body: Consumer<CreateHabitState>(
          builder: (context, createHabitState, _) {
            final restHabitData = restTimeState.restHabitDays(createHabitState.getHabitPeriod);
            _startTime = restHabitData[AppConstraints.startDateTime];
            _endTime = restHabitData[AppConstraints.endDateTime];
            return SingleChildScrollView(
              padding: AppStyles.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _habitTextController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLength: 75,
                    decoration: const InputDecoration(
                      hintText: AppStrings.habitHint,
                    ),
                  ),
                  const Text(
                    AppStrings.dayNumbers,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  CupertinoSlidingSegmentedControl<HabitPeriod>(
                    groupValue: createHabitState.getHabitPeriod,
                    thumbColor: appColors.onPrimary,
                    children: const <HabitPeriod, Widget>{
                      HabitPeriod.days21: Text(AppStrings.days21),
                      HabitPeriod.days40: Text(AppStrings.days40),
                      HabitPeriod.days66: Text(AppStrings.days66),
                      HabitPeriod.days90: Text(AppStrings.daya90),
                    },
                    onValueChanged: (HabitPeriod? habitPeriod) {
                      if (habitPeriod != null) {
                        createHabitState.setHabitPeriod = habitPeriod;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.color,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          createHabitState.setColorIndex = index;
                        },
                        child: CircleAvatar(
                          backgroundColor: AppStyles.taskHabitColors[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                          child: createHabitState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                    title: const Text(
                      AppStrings.dailyHabitNotification,
                      style: TextStyle(fontSize: 17),
                    ),
                    leading: IconButton(
                      onPressed: createHabitState.getIsRemind ? () async {
                        final currentTime = TimeOfDay.now();
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: currentTime.hour, minute: currentTime.minute),
                          helpText: AppStrings.selectTime,
                          hourLabelText: AppStrings.hours,
                          minuteLabelText: AppStrings.minutes,
                          cancelText: AppStrings.cancel,
                          confirmText: AppStrings.select,
                        );
                        if (selectedTime != null) {
                          _selectedDateTime = DateTime(_selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day, selectedTime.hour, selectedTime.minute,);
                        }
                      } : null,
                      icon: const Icon(Icons.access_time),
                    ),
                    trailing: Switch(
                      value: createHabitState.getIsRemind,
                      onChanged: (bool onChanged) {
                        createHabitState.setIsRemind = onChanged;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      if (_habitTextController.text.trim().isNotEmpty) {
                        Navigator.of(context).pop();
                        int notificationId = 0;

                        if (createHabitState.getIsRemind) {
                          final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
                          notificationId = randomNotificationNumber;
                          createHabitState.setTaskNotificationDate = _selectedDateTime.toIso8601String();

                          final int habitDaysCount = AppStyles.habitPeriodList[createHabitState.getHabitPeriod.index];
                          NotificationService().scheduleDailyNotifications(_selectedDateTime, AppStrings.appName, _habitTextController.text.trim(), randomNotificationNumber, habitDaysCount);
                        }

                        final habitMap = _createHabitMap(createHabitState, notificationId);
                        Provider.of<HabitDataState>(context, listen: false).createHabit(habitMap: habitMap);
                      } else {
                        _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.enterHabitTitle);
                      }
                    },
                    child: const Text(AppStrings.add),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Map<String, dynamic> _createHabitMap(CreateHabitState createHabitState, int notificationId) {
    final int habitDaysCount = AppStyles.habitPeriodList[createHabitState.getHabitPeriod.index];
    final List<int> completedDays = List<int>.filled(habitDaysCount, 0);
    final String completedDaysJson = jsonEncode(completedDays);

    return {
      'habit_title': _habitTextController.text.trim(),
      'create_date_time': DateTime.now().toIso8601String(),
      'complete_date_time': DateTime.now().toIso8601String(),
      'start_date_time': _startTime.toIso8601String(),
      'end_date_time': _endTime.toIso8601String(),
      'habit_period_index': createHabitState.getHabitPeriod.index,
      'habit_color_index': createHabitState.getColorIndex,
      'completed_days': completedDaysJson,
      'notification_id': notificationId,
      'notification_date': createHabitState.getIsRemind ? createHabitState.getTaskNotificationDate : '',
    };
  }

  void _showScaffoldMessage(Color color, Color textColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
