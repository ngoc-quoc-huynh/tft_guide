import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Injector.instance.messages.appName),
      ),
    );
  }
}
