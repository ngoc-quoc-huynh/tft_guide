import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemsLoadingIndicator extends StatelessWidget {
  const ItemsLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[300]!,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (_, __) => ListTile(
          leading: Container(
            width: 50,
            height: 50,
            color: Colors.white,
          ),
          title: Container(
            height: 14,
            color: Colors.white,
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemCount: 8,
      ),
    );
  }
}
