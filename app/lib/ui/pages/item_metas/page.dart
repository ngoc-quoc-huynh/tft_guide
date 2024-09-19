import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/item_metas/bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/item_metas/list_view.dart';
import 'package:tft_guide/ui/pages/item_metas/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/error_text.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';

class ItemMetasPage extends StatelessWidget {
  const ItemMetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemMetasBloc>(
      create: (_) => ItemMetasBloc()..add(const ItemMetasInitializeEvent()),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return LanguageListener(
      onLanguageChanged: (languageCode) =>
          _onLanguageChanged(context, languageCode),
      child: BlocBuilder<ItemMetasBloc, ItemMetasState>(
        builder: (context, state) => switch (state) {
          ItemMetasLoadInProgress() => const ItemLoadingIndicator(),
          ItemMetasLoadOnFailure() => const _Error(),
          ItemMetasLoadOnSuccess(:final items) when items.isEmpty =>
            const _Error(),
          ItemMetasLoadOnSuccess(:final items) =>
            ItemMetasListView(items: items),
        },
      ),
    );
  }

  void _onLanguageChanged(BuildContext context, LanguageCode languageCode) =>
      context
          .read<ItemMetasBloc>()
          .add(ItemMetasUpdateLanguageEvent(languageCode));
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
      ),
      child: Center(
        child: ErrorText(
          text: Injector.instance.translations.pages.itemMetas.errors.empty,
        ),
      ),
    );
  }
}
