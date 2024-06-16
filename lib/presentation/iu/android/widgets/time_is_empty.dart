import 'package:flutter/material.dart';

import '../../../../core/styles/app_styles.dart';

class TimeIsEmpty extends StatelessWidget {
  const TimeIsEmpty({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.add_task_rounded,
            size: 150,
            color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
