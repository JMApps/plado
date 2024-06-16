import 'package:flutter/material.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../widgets/main_back_button.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addingHabit),
        leading: const MainBackButton(),
      ),
      body: Container(),
    );
  }
}
