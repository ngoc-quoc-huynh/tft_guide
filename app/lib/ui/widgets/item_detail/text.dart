import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

sealed class ItemDetailCardText extends StatelessWidget {
  const ItemDetailCardText({super.key});

  const factory ItemDetailCardText.loading({
    Key? key,
  }) = _Loading;

  const factory ItemDetailCardText.text({
    required String text,
    Key? key,
  }) = _Text;

  @protected
  TextStyle? getTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge;
}

final class _Loading extends ItemDetailCardText {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Bone.multiText(
        lines: 3,
        style: getTextStyle(context),
      ),
    );
  }
}

final class _Text extends ItemDetailCardText {
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
