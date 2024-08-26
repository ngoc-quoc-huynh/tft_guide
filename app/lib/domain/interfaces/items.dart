import 'package:tft_guide/domain/models/item_preview.dart';

abstract interface class ItemsApi {
  const ItemsApi();

  Future<List<BaseItemPreview>> loadBaseItems();

  Future<List<FullItemPreview>> loadFullItems();
}
