import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/icons.dart';

class SpatulaBackground extends StatelessWidget {
  const SpatulaBackground({
    required this.child,
    super.key,
  });

  final Widget child;
  static const _alignment = Alignment(-2.5, 0.8);
  static const _size = 300.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: _alignment,
          child: Icon(
            TftIcons.spatula,
            size: _size,
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
        ),
        child,
      ],
    );
  }
}
