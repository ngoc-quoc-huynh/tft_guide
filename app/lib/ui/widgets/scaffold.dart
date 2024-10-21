import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SpatulaBackground(
        child: body,
      ),
    );
  }
}
