import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/file_storage_image.dart';

sealed class QuestionBody extends StatelessWidget {
  const QuestionBody({super.key});

  const factory QuestionBody.title({
    required String text,
    Key? key,
  }) = _Title;

  const factory QuestionBody.description({
    required String text,
    Key? key,
  }) = _Description;

  const factory QuestionBody.image({
    required String id,
    Key? key,
  }) = _Image;

  const factory QuestionBody.images({
    required String itemId1,
    required String itemId2,
    Key? key,
  }) = _Images;

  @protected
  static const imageSize = 100.0;
}

sealed class _Text extends QuestionBody {
  const _Text({
    required this.text,
    super.key,
  });

  final String text;

  TextStyle? getTextStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle(context),
    );
  }
}

final class _Title extends _Text {
  const _Title({
    required super.text,
    super.key,
  });

  @override
  TextStyle? getTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;
}

final class _Description extends _Text {
  const _Description({
    required super.text,
    super.key,
  });

  @override
  TextStyle? getTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;
}

final class _Image extends QuestionBody {
  const _Image({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return FileStorageImage(
      id: id,
      width: QuestionBody.imageSize,
      height: QuestionBody.imageSize,
    );
  }
}

final class _Images extends QuestionBody {
  const _Images({
    required this.itemId1,
    required this.itemId2,
    super.key,
  });

  final String itemId1;
  final String itemId2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FileStorageImage(
          id: itemId1,
          width: QuestionBody.imageSize,
          height: QuestionBody.imageSize,
        ),
        const Icon(Icons.add),
        FileStorageImage(
          id: itemId2,
          width: QuestionBody.imageSize,
          height: QuestionBody.imageSize,
        ),
      ],
    );
  }
}
