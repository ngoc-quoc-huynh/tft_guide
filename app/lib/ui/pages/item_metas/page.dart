import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/item_metas/bloc.dart';
import 'package:tft_guide/ui/pages/item_metas/list_view.dart';
import 'package:tft_guide/ui/pages/item_metas/loading_indicator.dart';

class ItemMetasPage extends StatelessWidget {
  const ItemMetasPage({super.key});

  static const routeName = 'item-metas';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemMetasBloc>(
      create: (_) => ItemMetasBloc()..add(const ItemMetasInitializeEvent()),
      child: BlocBuilder<ItemMetasBloc, ItemMetasState>(
        builder: (context, state) => switch (state) {
          ItemMetasLoadInProgress() => const ItemLoadingIndicator(),
          ItemMetasLoadOnSuccess(:final items) =>
            ItemMetasListView(items: items),
        },
      ),
    );
  }
}
