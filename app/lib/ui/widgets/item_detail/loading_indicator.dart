import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';

class ItemDetailLoadingIndicator extends StatelessWidget {
  const ItemDetailLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: LoadingIndicator(),
    );
  }
}
