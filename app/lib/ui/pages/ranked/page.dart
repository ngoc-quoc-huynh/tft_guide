import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/ranked/body/body.dart';
import 'package:tft_guide/ui/pages/ranked/header.dart';

class RankedPage extends StatelessWidget {
  const RankedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.horizontalPadding,
                vertical: Sizes.verticalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RankedHeader(),
                  SizedBox(height: 30),
                  RankedBody(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
