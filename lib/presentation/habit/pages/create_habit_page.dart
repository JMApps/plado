import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/enums/habit_period.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/create_habit_state.dart';
import '../../widgets/main_back_button.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _habitTextController = TextEditingController();
  late TimeOfDay _selectedTime;
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
            return SingleChildScrollView(
              padding: AppStyles.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
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
                      createHabitState.setHabitPeriod = habitPeriod!;
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
                        _selectedTime = TimeOfDay.now();
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute),
                          helpText: AppStrings.selectTime,
                          hourLabelText: AppStrings.hours,
                          minuteLabelText: AppStrings.minutes,
                          cancelText: AppStrings.cancel,
                          confirmText: AppStrings.select,
                        );
                        if (selectedTime != null) {
                          _selectedTime = selectedTime;
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
                      // Add habit
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
}
