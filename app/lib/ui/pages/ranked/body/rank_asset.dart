import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';

class RankedRankAsset extends StatelessWidget {
  const RankedRankAsset({
    required this.asset,
    super.key,
  });

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset(),
      height: 200,
      fit: BoxFit.contain,
    );
  }
}
