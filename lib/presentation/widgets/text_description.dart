import 'package:flutter/cupertino.dart';

import '../../core/styles/app_styles.dart';

class TextDescription extends StatelessWidget {
  const TextDescription({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.mainText,
    );
  }
}
