import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tft_guide/static/resources/assets.dart';

@immutable
sealed class Item extends Equatable {
  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.hint,
    required this.asset,
    required this.isSpecial,
  });

  final int id;
  final String name;
  final String description;
  final String hint;
  final Asset asset;
  final bool isSpecial;

  @override
  List<Object?> get props => [id, name, description, hint, asset, isSpecial];
}

final class BaseItem extends Item {
  const BaseItem({
    required super.id,
    required super.name,
    required super.description,
    required super.hint,
    required super.asset,
  }) : super(isSpecial: false);
}

final class FullItem extends Item {
  const FullItem({
    required super.id,
    required super.name,
    required super.description,
    required super.hint,
    required super.asset,
    required this.component1,
    required this.component2,
    super.isSpecial = false,
  });

  final BaseItem component1;
  final BaseItem component2;

  @override
  List<Object?> get props => [...super.props, component1, component2];
}