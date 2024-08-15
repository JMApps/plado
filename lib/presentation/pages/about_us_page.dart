import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../widgets/description_text.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isThemeLight = Theme.of(context).brightness == Brightness.light ? true : false;
    final double iconOpacity = isThemeLight ? 1 : 0.75;
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.aboutUs),
      ),
      body: SingleChildScrollView(
        padding: AppStyles.paddingMini,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DescriptionText(text: AppStrings.otherApplications),
            ListTile(
              onTap: () {},
              shape: AppStyles.shape,
              title: Text(Platform.isAndroid ? AppStrings.googlePlay : AppStrings.appStore),
              leading: Image.asset(
                Platform.isAndroid ? 'assets/icons/google-play.png' : 'assets/icons/appstore.png',
                width: 35,
                height: 35,
                opacity: AlwaysStoppedAnimation(iconOpacity),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const DescriptionText(text: AppStrings.weInSocials),
            ListTile(
              onTap: () {},
              shape: AppStyles.shape,
              title: const Text(AppStrings.telegram),
              leading: Image.asset(
                'assets/icons/telegram.png',
                width: 35,
                height: 35,
                opacity: AlwaysStoppedAnimation(iconOpacity),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {},
              shape: AppStyles.shape,
              title: const Text(AppStrings.instagram),
              leading: Image.asset(
                'assets/icons/instagram.png',
                width: 35,
                height: 35,
                opacity: AlwaysStoppedAnimation(iconOpacity),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const DescriptionText(text: AppStrings.rateApplication),
            ListTile(
              onTap: () {},
              shape: AppStyles.shape,
              title: const Text(AppStrings.rate),
              leading: Icon(Icons.star_half_rounded, color: appColors.primary, size: 35,),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const DescriptionText(text: AppStrings.version),
            const Padding(
              padding: AppStyles.paddingHorizontal,
              child: Text(
                '1.0.0',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
