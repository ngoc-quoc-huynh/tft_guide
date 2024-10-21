import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';

class ItemDetailLoadingIndicator extends StatelessWidget {
  const ItemDetailLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomAppBar(),
      body: LoadingIndicator(),
    );
  }
}
