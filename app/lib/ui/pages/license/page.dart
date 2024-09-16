import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/assets.dart';

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: _translations.appName,
      applicationVersion: Injector.instance.packageInfo.version,
      applicationIcon: Image.asset(
        Assets.launcherIcon(),
        height: 75,
        width: 75,
        fit: BoxFit.contain,
      ),
      applicationLegalese: _licensePageTranslation.copyright,
    );
  }

  static Translations get _translations => Injector.instance.translations;

  static TranslationsPagesLicenseEn get _licensePageTranslation =>
      _translations.pages.license;
}
