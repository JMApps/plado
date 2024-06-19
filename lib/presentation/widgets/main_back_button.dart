import 'package:flutter/material.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
    );
  }
}
