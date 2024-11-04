import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/item_detail/bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/item_detail/card.dart';
import 'package:tft_guide/ui/widgets/item_detail/error.dart';
import 'package:tft_guide/ui/widgets/item_detail/image.dart';
import 'package:tft_guide/ui/widgets/item_detail/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/item_detail/sliver_wrapper.dart';
import 'package:tft_guide/ui/widgets/item_detail/stats.dart';
import 'package:tft_guide/ui/widgets/item_detail/text.dart';
import 'package:tft_guide/ui/widgets/item_detail/title.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';
import 'package:tft_guide/ui/widgets/slivers/box.dart';
import 'package:tft_guide/ui/widgets/theme_provider.dart';
import 'package:tft_guide/ui/widgets/widget_observer.dart';

abstract class ItemDetailPage<Bloc extends ItemDetailBloc,
    Item extends ItemDetail> extends StatelessWidget {
  const ItemDetailPage({
    required this.id,
    required this.createBloc,
    this.trailing,
    super.key,
  });

  final String id;
  final Bloc Function(BuildContext) createBloc;
  final Widget Function(Item)? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<Bloc>(
      create: (context) => createBloc(context)
        ..add(
          ItemDetailInitializeEvent(
            id: id,
            brightness: theme.brightness,
            textTheme: theme.textTheme,
          ),
        ),
      child: BlocBuilder<Bloc, ItemDetailState>(
        builder: (context, state) => switch (state) {
          ItemDetailLoadInProgress() => const ItemDetailLoadingIndicator(),
          ItemDetailLoadOnSuccess<Item>(:final item, :final themeData) =>
            _Body<Item>(
              item: item,
              themeData: themeData,
              trailing: trailing,
            ),
          _ => ItemDetailErrorPage<Item>(id: id),
        },
      ),
    );
  }
}

class _Body<Item extends ItemDetail> extends StatelessWidget {
  const _Body({
    required this.item,
    required this.themeData,
    required this.trailing,
  });

  final Item item;
  final ThemeData? themeData;
  final Widget Function(Item)? trailing;

  @override
  Widget build(BuildContext context) {
    return WidgetObserver(
      onBrightnessChanged: (brightness) =>
          _onBrightnessChanged(context, brightness),
      child: LanguageListener(
        onLanguageChanged: (languageCode) =>
            _onLanguageChanged(context, languageCode),
        child: ThemeProvider(
          data: themeData,
          builder: (context) => CustomScaffold(
            appBar: CustomAppBar(
              title: Text(item.name),
            ),
            body: CustomScrollView(
              slivers: [
                const SliverSizedBox(height: Sizes.verticalPadding),
                SliverWrapperItemDetail(
                  child: ImageDetailImage(id: item.id),
                ),
                const SliverSizedBox(height: 20),
                SliverWrapperItemDetail(
                  child: ItemDetailCard(
                    title: ItemDetailCardTitle(
                      text: _translations.description,
                    ),
                    child: ItemDetailCardText(
                      text: item.description,
                    ),
                  ),
                ),
                if (item.hasStats) ...[
                  const SliverSizedBox(height: 10),
                  SliverWrapperItemDetail(
                    child: ItemDetailCard(
                      title: ItemDetailCardTitle(
                        text: _translations.stats,
                      ),
                      child: ItemDetailStats(
                        item: item,
                      ),
                    ),
                  ),
                ],
                const SliverSizedBox(height: 10),
                SliverWrapperItemDetail(
                  child: ItemDetailCard(
                    title: ItemDetailCardTitle(
                      text: _translations.hint,
                    ),
                    child: ItemDetailCardText(
                      text: item.hint,
                    ),
                  ),
                ),
                if (trailing case final Widget Function(Item) trailing) ...[
                  const SliverSizedBox(height: 10),
                  trailing.call(item),
                ],
                const SliverSizedBox(height: Sizes.verticalPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onBrightnessChanged(BuildContext context, Brightness brightness) =>
      context.read<BaseItemDetailBloc>().add(
            ItemDetailUpdateThemeDataEvent(
              brightness: brightness,
              textTheme: Theme.of(context).textTheme,
            ),
          );

  void _onLanguageChanged(BuildContext context, LanguageCode languageCode) {
    context.read<BaseItemDetailBloc>().add(
          ItemDetailUpdateLanguageCodeEvent(languageCode),
        );
  }

  static TranslationsPagesItemDetailEn get _translations =>
      Injector.instance.translations.pages.itemDetail;
}
