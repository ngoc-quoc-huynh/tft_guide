import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/error_image.dart';

class FileStorageImage extends StatelessWidget {
  const FileStorageImage({
    required this.id,
    required this.height,
    required this.width,
    this.gaplessPlayback = false,
    super.key,
  });

  final String id;
  final double height;
  final double width;
  final bool gaplessPlayback;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      Injector.instance.fileStorageApi.loadFile(id),
      height: height,
      width: width,
      fit: BoxFit.contain,
      gaplessPlayback: gaplessPlayback,
      errorBuilder: (_, __, ___) => ErrorImage(
        width: width,
        height: height,
      ),
    );
  }
}
