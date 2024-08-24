import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/pages/base_item_detail/page.dart';

part 'combine.dart';
part 'loading.dart';

sealed class FullItemDetailCombineBy extends StatelessWidget {
  const FullItemDetailCombineBy({super.key});

  const factory FullItemDetailCombineBy.combine({
    required String itemId1,
    required String itemId2,
    Key? key,
  }) = _Combine;

  const factory FullItemDetailCombineBy.loading({Key? key}) = _Loading;

  @protected
  static const padding = EdgeInsets.only(
    top: 10,
    bottom: 5,
  );
  static const imageSize = 50.0;
}
