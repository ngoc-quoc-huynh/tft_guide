import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class PatchNotesLoadingIndicator extends StatelessWidget {
  const PatchNotesLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Skeletonizer(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
              vertical: Sizes.verticalPadding,
            ),
            child: Column(
              children: [
                _Card(),
                _Card(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card();

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: Sizes.cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              BoneMock.date,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
            ),
            const SizedBox(height: 5),
            Bone.multiText(
              lines: _getRandomNumberOfLines(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  int _getRandomNumberOfLines() => Random().nextInt(8) + 3;
}
