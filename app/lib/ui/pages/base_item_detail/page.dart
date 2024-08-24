import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/item_detail/bloc.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/widgets/item_detail/card.dart';
import 'package:tft_guide/ui/widgets/item_detail/image.dart';
import 'package:tft_guide/ui/widgets/item_detail/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/item_detail/sliver_wrapper.dart';
import 'package:tft_guide/ui/widgets/item_detail/stats/stats.dart';
import 'package:tft_guide/ui/widgets/item_detail/text.dart';
import 'package:tft_guide/ui/widgets/item_detail/title.dart';
import 'package:tft_guide/ui/widgets/slivers/box.dart';

class BaseItemDetailPage extends StatelessWidget {
  const BaseItemDetailPage({
    required this.id,
    super.key,
  });

  final String id;

  static const routeName = 'base-item-detail';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BaseItemDetailBloc>(
      create: (_) => BaseItemDetailBloc()
        ..add(
          ItemDetailInitializeEvent(id),
        ),
      child: BlocBuilder<BaseItemDetailBloc, ItemDetailState>(
        builder: (context, state) => switch (state) {
          ItemDetailLoadInProgress() => const ItemDetailLoadingIndicator(),
          BaseItemDetailLoadOnSuccess(:final item) => _Body(item),
          ItemDetailLoadOnSuccess<ItemDetail>() => throw StateError(
              'This state will never be emitted within BaseItemDetailBloc.',
            ),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.item);

  final BaseItemDetail item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverSizedBox(height: 20),
          const SliverWrapperItemDetail(
            child: ImageDetailImage.image(),
          ),
          const SliverSizedBox(height: 20),
          SliverWrapperItemDetail(
            child: ItemDetailCard(
              title: ItemDetailCardTitle.text(
                text: _messages.description,
              ),
              child: ItemDetailCardText.text(
                text: item.description,
              ),
            ),
          ),
          const SliverSizedBox(height: 10),
          SliverWrapperItemDetail(
            child: ItemDetailCard(
              title: ItemDetailCardTitle.text(
                text: _messages.stats,
              ),
              child: ItemDetailStats.gridView(
                item: item,
              ),
            ),
          ),
          const SliverSizedBox(height: 10),
          SliverWrapperItemDetail(
            child: ItemDetailCard(
              title: ItemDetailCardTitle.text(
                text: _messages.hint,
              ),
              child: ItemDetailCardText.text(
                text: item.hint,
              ),
            ),
          ),
          const SliverSizedBox(height: 20),
        ],
      ),
    );
  }

  TranslationsPagesItemDetailDe get _messages =>
      Injector.instance.translations.pages.item_detail;
}
