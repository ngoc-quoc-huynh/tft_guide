import 'package:tft_guide/domain/models/item.dart';

abstract interface class ItemsAPI {
  const ItemsAPI();

  Future<List<BaseItem>> loadBaseItems();

  Future<List<FullItem>> loadFullItems();
}
