import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/habit/habit_color_state.dart';

class HabitColorList extends StatelessWidget {
  const HabitColorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitColorState>(
      builder: (BuildContext context, habitColorState, _) {
        return GridView.builder(
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
                habitColorState.setColorIndex = index;
              },
              child: CircleAvatar(
                backgroundColor: AppStyles.appColorList[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                child: habitColorState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }
}
