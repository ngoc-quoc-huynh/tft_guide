import 'package:flutter/material.dart';

class BaseItemDetailPage extends StatelessWidget {
  const BaseItemDetailPage({
    required this.id,
    super.key,
  });

  final String id;

  static const routeName = 'base-item-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('TODO: BaseItemDetailPage'),
      ),
    );
  }
}
