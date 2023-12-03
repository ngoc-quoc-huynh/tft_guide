import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';

class Background extends StatelessWidget {
  const Background({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.background.path),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: child,
    );
  }
}
