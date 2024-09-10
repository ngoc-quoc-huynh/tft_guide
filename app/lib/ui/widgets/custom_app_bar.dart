import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/icons.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.actions,
    super.key,
  }) : super(
          centerTitle: true,
          title: const _Title(),
          forceMaterialTransparency: true,
        );
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
