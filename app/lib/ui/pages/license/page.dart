import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/widgets/image/optimized.dart';

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: _translations.appName,
      applicationVersion: Injector.instance.packageInfo.version,
      applicationIcon: OptimizedImage.asset(
        Assets.launcherIcon,
        height: 75,
        width: 75,
      ),
      applicationLegalese: _licensePageTranslation.copyright,
    );
  }

  static Translations get _translations => Injector.instance.translations;

  static TranslationsPagesLicenseEn get _licensePageTranslation =>
      _translations.pages.license;
}
