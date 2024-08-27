import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/ui/widgets/file_storage_image.dart';

sealed class ImageDetailImage extends StatelessWidget {
  const ImageDetailImage({super.key});

  const factory ImageDetailImage.image({
    required String id,
    Key? key,
  }) = _Image;

  const factory ImageDetailImage.loading({
    Key? key,
  }) = _Loading;

  @protected
  static const imageSize = 150.0;
}

final class _Image extends ImageDetailImage {
  const _Image({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return FileStorageImage(
      id: id,
      width: ImageDetailImage.imageSize,
      height: ImageDetailImage.imageSize,
    );
  }
}

final class _Loading extends ImageDetailImage {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Bone.square(
      size: ImageDetailImage.imageSize,
    );
  }
}
