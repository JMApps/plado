import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plado/core/strings/app_constraints.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onTap: () {
                _launchUrl(Platform.isAndroid ? 'https://play.google.com/store/apps/dev?id=8649252597553656018' : 'https://apps.apple.com/ru/developer/imanil-binyaminov/id1564920953');
              },
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
            const Divider(indent: 16, endIndent: 16),
            const DescriptionText(text: AppStrings.weInSocials),
            ListTile(
              onTap: () {
                _launchUrl('https://t.me/jmapps');
              },
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
              onTap: () {
                _launchUrl('https://www.instagram.com/dev_muslim');
              },
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
            const Divider(indent: 16, endIndent: 16),
            const DescriptionText(text: AppStrings.rateApplication),
            ListTile(
              onTap: () {
                _launchUrl(Platform.isAndroid ? AppConstraints.appLinkAndroid : AppConstraints.appLinkIOS);
              },
              shape: AppStyles.shape,
              title: const Text(AppStrings.rate),
              leading: Icon(
                Icons.star_half_rounded,
                color: appColors.primary,
                size: 35,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const Divider(indent: 16, endIndent: 16),
            const DescriptionText(text: AppStrings.share),
            ListTile(
              onTap: () {
                Share.share(
                  '${AppStrings.fullAppName}\n\n${AppStrings.iOSVersion}\n${AppConstraints.appLinkIOS}\n\n${AppStrings.androidVersion}\n${AppConstraints.appLinkAndroid}',
                  sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 2 / 2),
                );
              },
              shape: AppStyles.shape,
              title: const Text(AppStrings.appName),
              leading: Icon(
                Icons.ios_share,
                color: appColors.primary,
                size: 30,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const Divider(indent: 16, endIndent: 16),
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
  Future<void> _launchUrl(String link) async {
    final Uri urlLink = Uri.parse(link);
    await launchUrl(urlLink);
  }
}
