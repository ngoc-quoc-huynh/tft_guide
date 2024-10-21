import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tft_guide/domain/utils/extensions/brightness.dart';
import 'package:tft_guide/static/resources/icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.leading,
    this.title,
    this.actions,
    this.centerTitle,
    this.forceMaterialTransparency = false,
    this.systemNavigationBarColor,
    super.key,
  });

  factory CustomAppBar.tft({
    Widget? leading,
    List<Widget>? actions,
    bool forceMaterialTransparency = false,
    Color? systemNavigationBarColor,
    Key? key,
  }) =>
      CustomAppBar(
        leading: leading,
        title: const _Title(),
        centerTitle: true,
        actions: actions,
        systemNavigationBarColor: systemNavigationBarColor,
        forceMaterialTransparency: forceMaterialTransparency,
        key: key,
      );

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool forceMaterialTransparency;
  final Color? systemNavigationBarColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    return AppBar(
      leading: leading,
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: brightness,
        statusBarIconBrightness: brightness.inverted,
        systemNavigationBarColor:
            systemNavigationBarColor ?? theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: brightness.inverted,
      ),
      forceMaterialTransparency: forceMaterialTransparency,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => _buildShader(context, bounds),
      child: Text(
        String.fromCharCode(TftIcons.logo.codePoint),
        style: const TextStyle(
          fontFamily: TftIcons.fontFamily,
          fontSize: kToolbarHeight - 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Shader _buildShader(BuildContext context, Rect bounds) {
    final primary = Theme.of(context).colorScheme.primary;
    return LinearGradient(
      colors: [
        const Color(0xFFF8B33F).harmonizeWith(primary),
        const Color(0xFFD78C3A).harmonizeWith(primary),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(
      Rect.fromLTWH(
        0,
        0,
        bounds.width,
        bounds.height,
      ),
    );
  }
}
