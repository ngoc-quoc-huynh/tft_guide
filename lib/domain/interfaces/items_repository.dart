import 'package:tft_guide/domain/models/item.dart';

abstract interface class ItemsRepository {
  const ItemsRepository();

  Future<List<BaseItem>> loadBaseItems();

  Future<List<FullItem>> loadFullItems();
}
