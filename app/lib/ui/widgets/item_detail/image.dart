import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/file_storage_image.dart';

class ImageDetailImage extends StatelessWidget {
  const ImageDetailImage({required this.id, super.key});

  final String id;

  static const _imageSize = 150.0;

  @override
  Widget build(BuildContext context) {
    return FileStorageImage(
      id: id,
      width: _imageSize,
      height: _imageSize,
    );
  }
}
