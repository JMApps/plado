import 'package:flutter/material.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../widgets/main_back_button.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addingTask),
        leading: const MainBackButton(),
      ),
      body: Container(),
    );
  }
}
