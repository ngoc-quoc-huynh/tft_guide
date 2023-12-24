import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/items/bloc.dart';
import 'package:tft_guide/ui/pages/items/list.dart';
import 'package:tft_guide/ui/pages/items/loading_indicator.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  static const routeName = 'items';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) => switch (state) {
        ItemsLoadInProgress() => const ItemsLoadingIndicator(),
        ItemsLoadOnSuccess() => ItemsList(items: state.items),
      },
    );
  }
}
