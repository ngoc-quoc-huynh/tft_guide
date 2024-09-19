import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/item_detail/bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
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
import 'package:tft_guide/ui/widgets/language/listener.dart';
import 'package:tft_guide/ui/widgets/slivers/box.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';
import 'package:tft_guide/ui/widgets/theme_provider.dart';
import 'package:tft_guide/ui/widgets/widget_observer.dart';

// TODO: Extract more common widgets
class BaseItemDetailPage extends StatelessWidget {
  const BaseItemDetailPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<BaseItemDetailBloc>(
      create: (_) => BaseItemDetailBloc()
        ..add(
          ItemDetailInitializeEvent(
            id: id,
            brightness: theme.brightness,
            textTheme: theme.textTheme,
          ),
        ),
      child: BlocBuilder<BaseItemDetailBloc, ItemDetailState>(
        builder: (context, state) => switch (state) {
          ItemDetailLoadInProgress() => const ItemDetailLoadingIndicator(),
          BaseItemDetailLoadOnSuccess(:final item, :final themeData) => _Body(
              item: item,
              themeData: themeData,
            ),
          ItemDetailLoadOnSuccess<ItemDetail>() => throw StateError(
              'This state will never be emitted within BaseItemDetailBloc.',
            ),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.item,
    required this.themeData,
  });

  final BaseItemDetail item;
  final ThemeData? themeData;

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
          child: Scaffold(
            appBar: AppBar(
              title: Text(item.name),
            ),
            body: SpatulaBackground(
              child: CustomScrollView(
                slivers: [
                  const SliverSizedBox(height: 20),
                  SliverWrapperItemDetail(
                    child: ImageDetailImage.image(
                      id: item.id,
                    ),
                  ),
                  const SliverSizedBox(height: 20),
                  SliverWrapperItemDetail(
                    child: ItemDetailCard(
                      title: ItemDetailCardTitle.text(
                        text: _translations.description,
                      ),
                      child: ItemDetailCardText.text(
                        text: item.description,
                      ),
                    ),
                  ),
                  if (item.hasStats) ...[
                    const SliverSizedBox(height: 10),
                    SliverWrapperItemDetail(
                      child: ItemDetailCard(
                        title: ItemDetailCardTitle.text(
                          text: _translations.stats,
                        ),
                        child: ItemDetailStats.gridView(
                          item: item,
                        ),
                      ),
                    ),
                  ],
                  const SliverSizedBox(height: 10),
                  SliverWrapperItemDetail(
                    child: ItemDetailCard(
                      title: ItemDetailCardTitle.text(
                        text: _translations.hint,
                      ),
                      child: ItemDetailCardText.text(
                        text: item.hint,
                      ),
                    ),
                  ),
                  const SliverSizedBox(height: 20),
                ],
              ),
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
