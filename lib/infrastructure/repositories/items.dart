import 'package:collection/collection.dart';
import 'package:tft_guide/domain/interfaces/items_repository.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
import 'package:tft_guide/static/resources/assets.dart';

final class LocalItemsRepository implements ItemsRepository {
  const LocalItemsRepository();

  @override
  Future<List<BaseItem>> loadRandomBaseItems(int amount) async =>
      _baseItems.sample(amount);

  static final _baseItems = [
    BaseItem(
      name: _baseItemsMessages.bfSword.name,
      description: _baseItemsMessages.bfSword.description,
      hint: _baseItemsMessages.bfSword.hint,
      asset: Assets.bfSword,
    ),
    BaseItem(
      name: _baseItemsMessages.chainVest.name,
      description: _baseItemsMessages.chainVest.description,
      hint: _baseItemsMessages.chainVest.hint,
      asset: Assets.chainVest,
    ),
    BaseItem(
      name: _baseItemsMessages.giantsBelt.name,
      description: _baseItemsMessages.giantsBelt.description,
      hint: _baseItemsMessages.giantsBelt.hint,
      asset: Assets.giantsBelt,
    ),
    BaseItem(
      name: _baseItemsMessages.needlesslyLargeRod.name,
      description: _baseItemsMessages.needlesslyLargeRod.description,
      hint: _baseItemsMessages.needlesslyLargeRod.hint,
      asset: Assets.needlesslyLargeRod,
    ),
    BaseItem(
      name: _baseItemsMessages.negatronCloak.name,
      description: _baseItemsMessages.negatronCloak.description,
      hint: _baseItemsMessages.negatronCloak.hint,
      asset: Assets.negatronCloak,
    ),
    BaseItem(
      name: _baseItemsMessages.recurveBow.name,
      description: _baseItemsMessages.recurveBow.description,
      hint: _baseItemsMessages.recurveBow.hint,
      asset: Assets.recurveBow,
    ),
    BaseItem(
      name: _baseItemsMessages.sparringGloves.name,
      description: _baseItemsMessages.sparringGloves.description,
      hint: _baseItemsMessages.sparringGloves.hint,
      asset: Assets.sparringGloves,
    ),
    BaseItem(
      name: _baseItemsMessages.spatula.name,
      description: _baseItemsMessages.spatula.description,
      hint: _baseItemsMessages.spatula.hint,
      asset: Assets.spatula,
    ),
    BaseItem(
      name: _baseItemsMessages.tearOfTheGoddess.name,
      description: _baseItemsMessages.tearOfTheGoddess.description,
      hint: _baseItemsMessages.tearOfTheGoddess.hint,
      asset: Assets.tearOfTheGoddess,
    ),
  ];

  static ItemsPagesMessages get _messages =>
      Injector.instance.messages.pages.items;

  static BaseItemsPagesMessages get _baseItemsMessages => _messages.base;
}
