import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/items/bloc.dart';
import 'package:tft_guide/domain/models/item.dart';

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    required this.id,
    required this.builder,
    super.key,
  });

  final int id;
  final Widget Function(BuildContext context, Item item) builder;

  @override
  Widget build(BuildContext context) {
    final state = context.read<ItemsBloc>().state as ItemsLoadOnSuccess;
    final item = [...state.baseItems, ...state.fullItems]
        .firstWhere((item) => item.id == id);
    return builder(context, item);
  }
}
