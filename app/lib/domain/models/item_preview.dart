import 'package:equatable/equatable.dart';
import 'package:tft_guide/static/resources/assets.dart';

sealed class ItemPreview extends Equatable {
  const ItemPreview({
    required this.id,
    required this.name,
    required this.description,
    required this.asset,
  });
  final int id;
  final String name;
  final String description;
  final Asset asset;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        asset,
      ];
}

final class BaseItemPreview extends ItemPreview {
  const BaseItemPreview({
    required super.id,
    required super.name,
    required super.description,
    required super.asset,
  });
}

final class FullItemPreview extends ItemPreview {
  const FullItemPreview({
    required super.id,
    required super.name,
    required super.description,
    required super.asset,
    required this.baseItem1,
    required this.baseItem2,
  });

  final BaseItemPreview baseItem1;
  final BaseItemPreview baseItem2;

  @override
  List<Object?> get props => [
        ...super.props,
        baseItem1,
        baseItem2,
      ];
}
