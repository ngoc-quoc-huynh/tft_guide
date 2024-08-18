import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/ranked/body/body.dart';
import 'package:tft_guide/ui/pages/ranked/header.dart';

class RankedPage extends StatelessWidget {
  const RankedPage({super.key});

  static const routeName = 'ranked';

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
        vertical: Sizes.verticalPadding,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RankedHeader(),
            SizedBox(height: 30),
            RankedBody(),
          ],
        ),
      ),
    );
  }
}