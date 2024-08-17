import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';

class SocialListTile extends StatelessWidget {
  const SocialListTile({
    super.key,
    required this.onSettingTap,
    required this.title,
    required this.imagePath,
  });

  final GestureTapCallback onSettingTap;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final isThemeLight = Theme.of(context).brightness == Brightness.light ? true : false;
    final double iconOpacity = isThemeLight ? 1 : 0.75;
    return ListTile(
      onTap: onSettingTap,
      shape: AppStyles.shape,
      title: Text(title),
      leading: Image.asset(
        imagePath,
        width: 35,
        height: 35,
        opacity: AlwaysStoppedAnimation(iconOpacity),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
