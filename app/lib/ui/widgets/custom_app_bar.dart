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

  // TODO: Harmonize color
  static const gradient = LinearGradient(
    colors: [
      Color(0xFFF8B33F),
      Color(0xFFD78C3A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        String.fromCharCode(TftIcons.logo.codePoint),
        style: const TextStyle(
          fontFamily: TftIcons.fontFamily,
          fontSize: kToolbarHeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
