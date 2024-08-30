import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

sealed class ItemDetailCardTitle extends StatelessWidget {
  const ItemDetailCardTitle({super.key});

  const factory ItemDetailCardTitle.loading({
    Key? key,
  }) = _Loading;

  const factory ItemDetailCardTitle.text({
    required String text,
    Key? key,
  }) = _Text;

  @protected
  TextStyle? getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.titleLarge
        ?.copyWith(color: theme.colorScheme.primary);
  }
}

final class _Loading extends ItemDetailCardTitle {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Bone.text(
      words: 1,
      style: getTextStyle(context),
    );
  }
}

final class _Text extends ItemDetailCardTitle {
  const _Text({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle(context),
    );
  }
}
