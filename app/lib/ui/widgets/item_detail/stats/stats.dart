import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/icons.dart';

part 'grid_view.dart';
part 'loading.dart';

sealed class ItemDetailStats extends StatelessWidget {
  const ItemDetailStats({super.key});

  const factory ItemDetailStats.gridView({
    required ItemDetail item,
    Key? key,
  }) = _GridView;

  const factory ItemDetailStats.loading({
    Key? key,
  }) = _Loading;

  @protected
  static const crossAxisCount = 4;
  @protected
  static const mainAxisSpacing = 10.0;
  static const padding = EdgeInsets.only(top: 10);
}
