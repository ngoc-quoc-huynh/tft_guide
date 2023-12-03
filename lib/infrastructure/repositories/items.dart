import 'package:tft_guide/domain/interfaces/items_repository.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
import 'package:tft_guide/static/resources/assets.dart';

final class LocalItemsRepository implements ItemsRepository {
  const LocalItemsRepository();

  @override
  Future<List<BaseItem>> loadBaseItems() async => _baseItems;

  @override
  Future<List<FullItem>> loadFullItems() async => _fullItems;

  static final _bfSword = BaseItem(
    id: 0,
    name: _baseItemsMessages.bfSword.name,
    description: _baseItemsMessages.bfSword.description,
    hint: _baseItemsMessages.bfSword.hint,
    asset: Assets.bfSword,
  );
  static final _chainVest = BaseItem(
    id: 1,
    name: _baseItemsMessages.chainVest.name,
    description: _baseItemsMessages.chainVest.description,
    hint: _baseItemsMessages.chainVest.hint,
    asset: Assets.chainVest,
  );
  static final _giantsBelt = BaseItem(
    id: 2,
    name: _baseItemsMessages.giantsBelt.name,
    description: _baseItemsMessages.giantsBelt.description,
    hint: _baseItemsMessages.giantsBelt.hint,
    asset: Assets.giantsBelt,
  );
  static final _needlesslyLargeRod = BaseItem(
    id: 3,
    name: _baseItemsMessages.needlesslyLargeRod.name,
    description: _baseItemsMessages.needlesslyLargeRod.description,
    hint: _baseItemsMessages.needlesslyLargeRod.hint,
    asset: Assets.needlesslyLargeRod,
  );
  static final _negatronCloak = BaseItem(
    id: 4,
    name: _baseItemsMessages.negatronCloak.name,
    description: _baseItemsMessages.negatronCloak.description,
    hint: _baseItemsMessages.negatronCloak.hint,
    asset: Assets.negatronCloak,
  );
  static final _recurveBow = BaseItem(
    id: 5,
    name: _baseItemsMessages.recurveBow.name,
    description: _baseItemsMessages.recurveBow.description,
    hint: _baseItemsMessages.recurveBow.hint,
    asset: Assets.recurveBow,
  );
  static final _sparringGloves = BaseItem(
    id: 6,
    name: _baseItemsMessages.sparringGloves.name,
    description: _baseItemsMessages.sparringGloves.description,
    hint: _baseItemsMessages.sparringGloves.hint,
    asset: Assets.sparringGloves,
  );
  static final _spatula = BaseItem(
    id: 7,
    name: _baseItemsMessages.spatula.name,
    description: _baseItemsMessages.spatula.description,
    hint: _baseItemsMessages.spatula.hint,
    asset: Assets.spatula,
  );
  static final _tearOfTheGoddess = BaseItem(
    id: 8,
    name: _baseItemsMessages.tearOfTheGoddess.name,
    description: _baseItemsMessages.tearOfTheGoddess.description,
    hint: _baseItemsMessages.tearOfTheGoddess.hint,
    asset: Assets.tearOfTheGoddess,
  );

  static final _baseItems = [
    _bfSword,
    _chainVest,
    _giantsBelt,
    _needlesslyLargeRod,
    _negatronCloak,
    _recurveBow,
    _sparringGloves,
    _spatula,
    _tearOfTheGoddess,
  ];

  static final _fullItems = [
    FullItem(
      id: 9,
      name: _fullItemsMessages.adaptiveHelm.name,
      description: _fullItemsMessages.adaptiveHelm.description,
      hint: _fullItemsMessages.adaptiveHelm.hint,
      asset: Assets.adaptiveHelm,
      component1: _negatronCloak,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 10,
      name: _fullItemsMessages.archangelsStaff.name,
      description: _fullItemsMessages.archangelsStaff.description,
      hint: _fullItemsMessages.archangelsStaff.hint,
      asset: Assets.archangelsStaff,
      component1: _needlesslyLargeRod,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 11,
      name: _fullItemsMessages.bloodthirster.name,
      description: _fullItemsMessages.bloodthirster.description,
      hint: _fullItemsMessages.bloodthirster.hint,
      asset: Assets.bloodthirster,
      component1: _bfSword,
      component2: _negatronCloak,
    ),
    FullItem(
      id: 12,
      name: _fullItemsMessages.blueBuff.name,
      description: _fullItemsMessages.blueBuff.description,
      hint: _fullItemsMessages.blueBuff.hint,
      asset: Assets.blueBuff,
      component1: _tearOfTheGoddess,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 13,
      name: _fullItemsMessages.brambleVest.name,
      description: _fullItemsMessages.brambleVest.description,
      hint: _fullItemsMessages.brambleVest.hint,
      asset: Assets.brambleVest,
      component1: _chainVest,
      component2: _chainVest,
    ),
    FullItem(
      id: 14,
      name: _fullItemsMessages.crownguard.name,
      description: _fullItemsMessages.crownguard.description,
      hint: _fullItemsMessages.crownguard.hint,
      asset: Assets.crownguard,
      component1: _chainVest,
      component2: _needlesslyLargeRod,
    ),
    FullItem(
      id: 15,
      name: _fullItemsMessages.deathblade.name,
      description: _fullItemsMessages.deathblade.description,
      hint: _fullItemsMessages.deathblade.hint,
      asset: Assets.deathblade,
      component1: _bfSword,
      component2: _bfSword,
    ),
    FullItem(
      id: 16,
      name: _fullItemsMessages.dragonsClaw.name,
      description: _fullItemsMessages.dragonsClaw.description,
      hint: _fullItemsMessages.dragonsClaw.hint,
      asset: Assets.dragonsClaw,
      component1: _negatronCloak,
      component2: _negatronCloak,
    ),
    FullItem(
      id: 17,
      name: _fullItemsMessages.edgeOfNight.name,
      description: _fullItemsMessages.edgeOfNight.description,
      hint: _fullItemsMessages.edgeOfNight.hint,
      asset: Assets.edgeOfNight,
      component1: _bfSword,
      component2: _chainVest,
    ),
    FullItem(
      id: 18,
      name: _fullItemsMessages.evenshroud.name,
      description: _fullItemsMessages.evenshroud.description,
      hint: _fullItemsMessages.evenshroud.hint,
      asset: Assets.evenshroud,
      component1: _giantsBelt,
      component2: _negatronCloak,
    ),
    FullItem(
      id: 19,
      name: _fullItemsMessages.gargoyleStoneplate.name,
      description: _fullItemsMessages.gargoyleStoneplate.description,
      hint: _fullItemsMessages.gargoyleStoneplate.hint,
      asset: Assets.gargoyleStoneplate,
      component1: _chainVest,
      component2: _negatronCloak,
    ),
    FullItem(
      id: 20,
      name: _fullItemsMessages.giantSlayer.name,
      description: _fullItemsMessages.giantSlayer.description,
      hint: _fullItemsMessages.giantSlayer.hint,
      asset: Assets.giantSlayer,
      component1: _bfSword,
      component2: _recurveBow,
    ),
    FullItem(
      id: 21,
      name: _fullItemsMessages.guardbreaker.name,
      description: _fullItemsMessages.guardbreaker.description,
      hint: _fullItemsMessages.guardbreaker.hint,
      asset: Assets.guardbreaker,
      component1: _giantsBelt,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 22,
      name: _fullItemsMessages.guinsoosRageblade.name,
      description: _fullItemsMessages.guinsoosRageblade.description,
      hint: _fullItemsMessages.guinsoosRageblade.hint,
      asset: Assets.guinsoosRageblade,
      component1: _needlesslyLargeRod,
      component2: _recurveBow,
    ),
    FullItem(
      id: 23,
      name: _fullItemsMessages.handOfJustice.name,
      description: _fullItemsMessages.handOfJustice.description,
      hint: _fullItemsMessages.handOfJustice.hint,
      asset: Assets.handOfJustice,
      component1: _tearOfTheGoddess,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 24,
      name: _fullItemsMessages.hextechGunblade.name,
      description: _fullItemsMessages.hextechGunblade.description,
      hint: _fullItemsMessages.hextechGunblade.hint,
      asset: Assets.hextechGunblade,
      component1: _bfSword,
      component2: _needlesslyLargeRod,
    ),
    FullItem(
      id: 25,
      name: _fullItemsMessages.infinityEdge.name,
      description: _fullItemsMessages.infinityEdge.description,
      hint: _fullItemsMessages.infinityEdge.hint,
      asset: Assets.infinityEdge,
      component1: _bfSword,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 26,
      name: _fullItemsMessages.ionicSpark.name,
      description: _fullItemsMessages.ionicSpark.description,
      hint: _fullItemsMessages.ionicSpark.hint,
      asset: Assets.ionicSpark,
      component1: _needlesslyLargeRod,
      component2: _negatronCloak,
    ),
    FullItem(
      id: 27,
      name: _fullItemsMessages.jeweledGauntlet.name,
      description: _fullItemsMessages.jeweledGauntlet.description,
      hint: _fullItemsMessages.jeweledGauntlet.hint,
      asset: Assets.jeweledGauntlet,
      component1: _needlesslyLargeRod,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 28,
      name: _fullItemsMessages.lastWhisper.name,
      description: _fullItemsMessages.lastWhisper.description,
      hint: _fullItemsMessages.lastWhisper.hint,
      asset: Assets.lastWhisper,
      component1: _recurveBow,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 29,
      name: _fullItemsMessages.morellonomicon.name,
      description: _fullItemsMessages.morellonomicon.description,
      hint: _fullItemsMessages.morellonomicon.hint,
      asset: Assets.morellonomicon,
      component1: _needlesslyLargeRod,
      component2: _giantsBelt,
    ),
    FullItem(
      id: 30,
      name: _fullItemsMessages.nashorsTooth.name,
      description: _fullItemsMessages.nashorsTooth.description,
      hint: _fullItemsMessages.nashorsTooth.hint,
      asset: Assets.nashorsTooth,
      component1: _giantsBelt,
      component2: _recurveBow,
    ),
    FullItem(
      id: 31,
      name: _fullItemsMessages.protectorsVow.name,
      description: _fullItemsMessages.protectorsVow.description,
      hint: _fullItemsMessages.protectorsVow.hint,
      asset: Assets.protectorsVow,
      component1: _chainVest,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 32,
      name: _fullItemsMessages.quicksilver.name,
      description: _fullItemsMessages.quicksilver.description,
      hint: _fullItemsMessages.quicksilver.hint,
      asset: Assets.quicksilver,
      component1: _negatronCloak,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 33,
      name: _fullItemsMessages.rabadonsDeathcap.name,
      description: _fullItemsMessages.rabadonsDeathcap.description,
      hint: _fullItemsMessages.rabadonsDeathcap.hint,
      asset: Assets.rabadonsDeathcap,
      component1: _needlesslyLargeRod,
      component2: _needlesslyLargeRod,
    ),
    FullItem(
      id: 34,
      name: _fullItemsMessages.redBuff.name,
      description: _fullItemsMessages.redBuff.description,
      hint: _fullItemsMessages.redBuff.hint,
      asset: Assets.redBuff,
      component1: _recurveBow,
      component2: _recurveBow,
    ),
    FullItem(
      id: 35,
      name: _fullItemsMessages.redemption.name,
      description: _fullItemsMessages.redemption.description,
      hint: _fullItemsMessages.redemption.hint,
      asset: Assets.redemption,
      component1: _giantsBelt,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 36,
      name: _fullItemsMessages.runaansHurricane.name,
      description: _fullItemsMessages.runaansHurricane.description,
      hint: _fullItemsMessages.runaansHurricane.hint,
      asset: Assets.runaansHurricane,
      component1: _negatronCloak,
      component2: _recurveBow,
    ),
    FullItem(
      id: 37,
      name: _fullItemsMessages.spearOfShojin.name,
      description: _fullItemsMessages.spearOfShojin.description,
      hint: _fullItemsMessages.spearOfShojin.hint,
      asset: Assets.spearOfShojin,
      component1: _bfSword,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 38,
      name: _fullItemsMessages.statikkShiv.name,
      description: _fullItemsMessages.statikkShiv.description,
      hint: _fullItemsMessages.statikkShiv.hint,
      asset: Assets.statikkShiv,
      component1: _recurveBow,
      component2: _tearOfTheGoddess,
    ),
    FullItem(
      id: 39,
      name: _fullItemsMessages.steadfastHeart.name,
      description: _fullItemsMessages.steadfastHeart.description,
      hint: _fullItemsMessages.steadfastHeart.hint,
      asset: Assets.steadfastHeart,
      component1: _chainVest,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 40,
      name: _fullItemsMessages.steraksGage.name,
      description: _fullItemsMessages.steraksGage.description,
      hint: _fullItemsMessages.steraksGage.hint,
      asset: Assets.steraksGage,
      component1: _bfSword,
      component2: _giantsBelt,
    ),
    FullItem(
      id: 41,
      name: _fullItemsMessages.sunfireCape.name,
      description: _fullItemsMessages.sunfireCape.description,
      hint: _fullItemsMessages.sunfireCape.hint,
      asset: Assets.sunfireCape,
      component1: _giantsBelt,
      component2: _chainVest,
    ),
    FullItem(
      id: 42,
      name: _fullItemsMessages.tacticiansCrown.name,
      description: _fullItemsMessages.tacticiansCrown.description,
      hint: _fullItemsMessages.tacticiansCrown.hint,
      asset: Assets.tacticiansCrown,
      component1: _spatula,
      component2: _spatula,
    ),
    FullItem(
      id: 43,
      name: _fullItemsMessages.thiefsGloves.name,
      description: _fullItemsMessages.thiefsGloves.description,
      hint: _fullItemsMessages.thiefsGloves.hint,
      asset: Assets.thiefsGloves,
      component1: _sparringGloves,
      component2: _sparringGloves,
    ),
    FullItem(
      id: 44,
      name: _fullItemsMessages.titansResolve.name,
      description: _fullItemsMessages.titansResolve.description,
      hint: _fullItemsMessages.titansResolve.hint,
      asset: Assets.titansResolve,
      component1: _chainVest,
      component2: _recurveBow,
    ),
    FullItem(
      id: 45,
      name: _fullItemsMessages.warmogsArmor.name,
      description: _fullItemsMessages.warmogsArmor.description,
      hint: _fullItemsMessages.warmogsArmor.hint,
      asset: Assets.warmogsArmor,
      component1: _giantsBelt,
      component2: _giantsBelt,
    ),
  ];

  static ItemsPagesMessages get _messages =>
      Injector.instance.messages.pages.items;

  static BaseItemsPagesMessages get _baseItemsMessages => _messages.base;

  static FullItemsPagesMessages get _fullItemsMessages => _messages.full;
}
