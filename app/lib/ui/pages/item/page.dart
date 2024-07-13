import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({required this.id, super.key});

  final int id;

  static const routeName = 'item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('TODO'),
      ),
    );
  }
}
