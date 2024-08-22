import 'package:flutter/material.dart';

class FullItemDetailPage extends StatelessWidget {
  const FullItemDetailPage({
    required this.id,
    super.key,
  });

  final String id;

  static const routeName = 'full-item-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('TODO: FullItemDetailPage'),
      ),
    );
  }
}
