import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../state/habit/habit_title_state.dart';

class HabitTextField extends StatefulWidget {
  const HabitTextField({
    super.key,
  });

  @override
  State<HabitTextField> createState() => _HabitTextFieldState();
}

class _HabitTextFieldState extends State<HabitTextField> {
  late final TextEditingController _habitTextController;

  @override
  void initState() {
    super.initState();
    _habitTextController = TextEditingController(text: context.read<HabitTitleState>().getHabitTitle);
  }

  @override
  void dispose() {
    _habitTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<HabitTitleState>(
      builder: (BuildContext context, habitTitleState, _) {
        return TextField(
          controller: _habitTextController,
          autofocus: context.read<HabitTitleState>().getHabitTitle.isEmpty ? true : false,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLength: 75,
          decoration: InputDecoration(
            hintText: appLocale.habitHint,
          ),
          onChanged: (String inputValue) {
            habitTitleState.setTaskTitle = inputValue;
          },
        );
      },
    );
  }
}
