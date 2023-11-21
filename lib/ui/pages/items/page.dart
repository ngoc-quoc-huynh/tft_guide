import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  static const route = 'ranked';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Injector.instance.messages.pages.items.title),
    );
  }
}
