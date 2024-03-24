import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/static/resources/colors.dart';

class OptionBox extends StatelessWidget {
  OptionBox.byText({
    required String text,
    required this.onSelect,
    required this.isSelected,
    this.showCorrect = false,
    super.key,
  }) : child = Text(
          text,
          textAlign: TextAlign.center,
        );

  OptionBox.byImage({
    required Asset asset,
    required this.onSelect,
    required this.isSelected,
    this.showCorrect = false,
    super.key,
  }) : child = Image.asset(
          asset.path,
          width: 50,
          height: 50,
        );

  final VoidCallback onSelect;
  final bool isSelected;
  final bool showCorrect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.fromBorderSide(
            BorderSide(
              color: switch (showCorrect) {
                true => Colors.green,
                false when isSelected => CustomColors.orange,
                false => Colors.grey,
              },
              width: 2,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
