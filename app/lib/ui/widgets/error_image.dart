import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Icon(Icons.no_photography),
    );
  }
}
