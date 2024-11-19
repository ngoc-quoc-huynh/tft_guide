import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/asset.dart';
import 'package:tft_guide/ui/widgets/error_image.dart';

final class OptimizedImage extends StatelessWidget {
  OptimizedImage.asset(
    Asset asset, {
    this.height,
    this.width,
    this.gaplessPlayback = false,
    super.key,
  }) : image = AssetImage(asset());

  OptimizedImage.file(
    File file, {
    required this.height,
    required this.width,
    this.gaplessPlayback = false,
    super.key,
  }) : image = FileImage(file);

  final ImageProvider image;
  final double? height;
  final double? width;
  final bool gaplessPlayback;

  @override
  Widget build(BuildContext context) {
    final devicePixelRation = MediaQuery.devicePixelRatioOf(context);
    return Image(
      image: ResizeImage(
        height: switch (height) {
          null => null,
          final height => (height * devicePixelRation).toInt()
        },
        width: switch (width) {
          null => null,
          final width => (width * devicePixelRation).toInt()
        },
        image,
      ),
      height: height,
      width: width,
      gaplessPlayback: gaplessPlayback,
      errorBuilder: (_, __, ___) => ErrorImage(
        width: width,
        height: height,
      ),
    );
  }
}
