import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class RankedPage extends StatelessWidget {
  const RankedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Injector.instance.messages.pages.ranked.title),
    );
  }
}
