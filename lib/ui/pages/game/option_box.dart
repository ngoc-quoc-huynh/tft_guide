import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';

class OptionBox extends StatelessWidget {
  OptionBox.byText({required String text, super.key})
      : child = Text(
          text,
          textAlign: TextAlign.center,
        );

  OptionBox.byImage({required Asset asset, super.key})
      : child = Image.asset(
          asset.path,
          width: 50,
          height: 50,
        );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      child: child,
    );
  }
}
