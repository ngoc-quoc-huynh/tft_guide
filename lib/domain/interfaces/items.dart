import 'package:tft_guide/domain/models/item_preview.dart';

abstract interface class ItemsAPI {
  const ItemsAPI();

  Future<List<BaseItemPreview>> loadBaseItems();

  Future<List<FullItemPreview>> loadFullItems();
}
