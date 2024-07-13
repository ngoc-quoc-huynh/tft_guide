import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/domain/models/item_preview.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/assets.dart';

final class LocalItemsRepository implements ItemsAPI {
  const LocalItemsRepository();

  @override
  Future<List<BaseItemPreview>> loadBaseItems() async => _baseItems;

  @override
  Future<List<FullItemPreview>> loadFullItems() async => _fullItems;

  static final _bfSword = BaseItemPreview(
    id: 0,
    name: _baseItemsTranslations.bfSword.name,
    description: _baseItemsTranslations.bfSword.description,
    asset: Assets.bfSword,
  );
  static final _chainVest = BaseItemPreview(
    id: 1,
    name: _baseItemsTranslations.chainVest.name,
    description: _baseItemsTranslations.chainVest.description,
    asset: Assets.chainVest,
  );
  static final _giantsBelt = BaseItemPreview(
    id: 2,
    name: _baseItemsTranslations.giantsBelt.name,
    description: _baseItemsTranslations.giantsBelt.description,
    asset: Assets.giantsBelt,
  );
  static final _needlesslyLargeRod = BaseItemPreview(
    id: 3,
    name: _baseItemsTranslations.needlesslyLargeRod.name,
    description: _baseItemsTranslations.needlesslyLargeRod.description,
    asset: Assets.needlesslyLargeRod,
  );
  static final _negatronCloak = BaseItemPreview(
    id: 4,
    name: _baseItemsTranslations.negatronCloak.name,
    description: _baseItemsTranslations.negatronCloak.description,
    asset: Assets.negatronCloak,
  );
  static final _recurveBow = BaseItemPreview(
    id: 5,
    name: _baseItemsTranslations.recurveBow.name,
    description: _baseItemsTranslations.recurveBow.description,
    asset: Assets.recurveBow,
  );
  static final _sparringGloves = BaseItemPreview(
    id: 6,
    name: _baseItemsTranslations.sparringGloves.name,
    description: _baseItemsTranslations.sparringGloves.description,
    asset: Assets.sparringGloves,
  );
  static final _spatula = BaseItemPreview(
    id: 7,
    name: _baseItemsTranslations.spatula.name,
    description: _baseItemsTranslations.spatula.description,
    asset: Assets.spatula,
  );
  static final _tearOfTheGoddess = BaseItemPreview(
    id: 8,
    name: _baseItemsTranslations.tearOfTheGoddess.name,
    description: _baseItemsTranslations.tearOfTheGoddess.description,
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
    FullItemPreview(
      id: 9,
      name: _fullItemsTranslations.adaptiveHelm.name,
      description: _fullItemsTranslations.adaptiveHelm.description,
      asset: Assets.adaptiveHelm,
      baseItem1: _negatronCloak,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 10,
      name: _fullItemsTranslations.archangelsStaff.name,
      description: _fullItemsTranslations.archangelsStaff.description,
      asset: Assets.archangelsStaff,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 11,
      name: _fullItemsTranslations.bloodthirster.name,
      description: _fullItemsTranslations.bloodthirster.description,
      asset: Assets.bloodthirster,
      baseItem1: _bfSword,
      baseItem2: _negatronCloak,
    ),
    FullItemPreview(
      id: 12,
      name: _fullItemsTranslations.blueBuff.name,
      description: _fullItemsTranslations.blueBuff.description,
      asset: Assets.blueBuff,
      baseItem1: _tearOfTheGoddess,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 13,
      name: _fullItemsTranslations.brambleVest.name,
      description: _fullItemsTranslations.brambleVest.description,
      asset: Assets.brambleVest,
      baseItem1: _chainVest,
      baseItem2: _chainVest,
    ),
    FullItemPreview(
      id: 14,
      name: _fullItemsTranslations.crownguard.name,
      description: _fullItemsTranslations.crownguard.description,
      asset: Assets.crownguard,
      baseItem1: _chainVest,
      baseItem2: _needlesslyLargeRod,
    ),
    FullItemPreview(
      id: 15,
      name: _fullItemsTranslations.deathblade.name,
      description: _fullItemsTranslations.deathblade.description,
      asset: Assets.deathblade,
      baseItem1: _bfSword,
      baseItem2: _bfSword,
    ),
    FullItemPreview(
      id: 16,
      name: _fullItemsTranslations.dragonsClaw.name,
      description: _fullItemsTranslations.dragonsClaw.description,
      asset: Assets.dragonsClaw,
      baseItem1: _negatronCloak,
      baseItem2: _negatronCloak,
    ),
    FullItemPreview(
      id: 17,
      name: _fullItemsTranslations.edgeOfNight.name,
      description: _fullItemsTranslations.edgeOfNight.description,
      asset: Assets.edgeOfNight,
      baseItem1: _bfSword,
      baseItem2: _chainVest,
    ),
    FullItemPreview(
      id: 18,
      name: _fullItemsTranslations.evenshroud.name,
      description: _fullItemsTranslations.evenshroud.description,
      asset: Assets.evenshroud,
      baseItem1: _giantsBelt,
      baseItem2: _negatronCloak,
    ),
    FullItemPreview(
      id: 19,
      name: _fullItemsTranslations.gargoyleStoneplate.name,
      description: _fullItemsTranslations.gargoyleStoneplate.description,
      asset: Assets.gargoyleStoneplate,
      baseItem1: _chainVest,
      baseItem2: _negatronCloak,
    ),
    FullItemPreview(
      id: 20,
      name: _fullItemsTranslations.giantSlayer.name,
      description: _fullItemsTranslations.giantSlayer.description,
      asset: Assets.giantSlayer,
      baseItem1: _bfSword,
      baseItem2: _recurveBow,
    ),
    FullItemPreview(
      id: 21,
      name: _fullItemsTranslations.guardbreaker.name,
      description: _fullItemsTranslations.guardbreaker.description,
      asset: Assets.guardbreaker,
      baseItem1: _giantsBelt,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 22,
      name: _fullItemsTranslations.guinsoosRageblade.name,
      description: _fullItemsTranslations.guinsoosRageblade.description,
      asset: Assets.guinsoosRageblade,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _recurveBow,
    ),
    FullItemPreview(
      id: 23,
      name: _fullItemsTranslations.handOfJustice.name,
      description: _fullItemsTranslations.handOfJustice.description,
      asset: Assets.handOfJustice,
      baseItem1: _tearOfTheGoddess,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 24,
      name: _fullItemsTranslations.hextechGunblade.name,
      description: _fullItemsTranslations.hextechGunblade.description,
      asset: Assets.hextechGunblade,
      baseItem1: _bfSword,
      baseItem2: _needlesslyLargeRod,
    ),
    FullItemPreview(
      id: 25,
      name: _fullItemsTranslations.infinityEdge.name,
      description: _fullItemsTranslations.infinityEdge.description,
      asset: Assets.infinityEdge,
      baseItem1: _bfSword,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 26,
      name: _fullItemsTranslations.ionicSpark.name,
      description: _fullItemsTranslations.ionicSpark.description,
      asset: Assets.ionicSpark,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _negatronCloak,
    ),
    FullItemPreview(
      id: 27,
      name: _fullItemsTranslations.jeweledGauntlet.name,
      description: _fullItemsTranslations.jeweledGauntlet.description,
      asset: Assets.jeweledGauntlet,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 28,
      name: _fullItemsTranslations.lastWhisper.name,
      description: _fullItemsTranslations.lastWhisper.description,
      asset: Assets.lastWhisper,
      baseItem1: _recurveBow,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 29,
      name: _fullItemsTranslations.morellonomicon.name,
      description: _fullItemsTranslations.morellonomicon.description,
      asset: Assets.morellonomicon,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _giantsBelt,
    ),
    FullItemPreview(
      id: 30,
      name: _fullItemsTranslations.nashorsTooth.name,
      description: _fullItemsTranslations.nashorsTooth.description,
      asset: Assets.nashorsTooth,
      baseItem1: _giantsBelt,
      baseItem2: _recurveBow,
    ),
    FullItemPreview(
      id: 31,
      name: _fullItemsTranslations.protectorsVow.name,
      description: _fullItemsTranslations.protectorsVow.description,
      asset: Assets.protectorsVow,
      baseItem1: _chainVest,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 32,
      name: _fullItemsTranslations.quicksilver.name,
      description: _fullItemsTranslations.quicksilver.description,
      asset: Assets.quicksilver,
      baseItem1: _negatronCloak,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 33,
      name: _fullItemsTranslations.rabadonsDeathcap.name,
      description: _fullItemsTranslations.rabadonsDeathcap.description,
      asset: Assets.rabadonsDeathcap,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _needlesslyLargeRod,
    ),
    FullItemPreview(
      id: 34,
      name: _fullItemsTranslations.redBuff.name,
      description: _fullItemsTranslations.redBuff.description,
      asset: Assets.redBuff,
      baseItem1: _recurveBow,
      baseItem2: _recurveBow,
    ),
    FullItemPreview(
      id: 35,
      name: _fullItemsTranslations.redemption.name,
      description: _fullItemsTranslations.redemption.description,
      asset: Assets.redemption,
      baseItem1: _giantsBelt,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 36,
      name: _fullItemsTranslations.runaansHurricane.name,
      description: _fullItemsTranslations.runaansHurricane.description,
      asset: Assets.runaansHurricane,
      baseItem1: _negatronCloak,
      baseItem2: _recurveBow,
    ),
    FullItemPreview(
      id: 37,
      name: _fullItemsTranslations.spearOfShojin.name,
      description: _fullItemsTranslations.spearOfShojin.description,
      asset: Assets.spearOfShojin,
      baseItem1: _bfSword,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 38,
      name: _fullItemsTranslations.statikkShiv.name,
      description: _fullItemsTranslations.statikkShiv.description,
      asset: Assets.statikkShiv,
      baseItem1: _recurveBow,
      baseItem2: _tearOfTheGoddess,
    ),
    FullItemPreview(
      id: 39,
      name: _fullItemsTranslations.steadfastHeart.name,
      description: _fullItemsTranslations.steadfastHeart.description,
      asset: Assets.steadfastHeart,
      baseItem1: _chainVest,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 40,
      name: _fullItemsTranslations.steraksGage.name,
      description: _fullItemsTranslations.steraksGage.description,
      asset: Assets.steraksGage,
      baseItem1: _bfSword,
      baseItem2: _giantsBelt,
    ),
    FullItemPreview(
      id: 41,
      name: _fullItemsTranslations.sunfireCape.name,
      description: _fullItemsTranslations.sunfireCape.description,
      asset: Assets.sunfireCape,
      baseItem1: _giantsBelt,
      baseItem2: _chainVest,
    ),
    FullItemPreview(
      id: 42,
      name: _fullItemsTranslations.tacticiansCrown.name,
      description: _fullItemsTranslations.tacticiansCrown.description,
      asset: Assets.tacticiansCrown,
      baseItem1: _spatula,
      baseItem2: _spatula,
    ),
    FullItemPreview(
      id: 43,
      name: _fullItemsTranslations.thiefsGloves.name,
      description: _fullItemsTranslations.thiefsGloves.description,
      asset: Assets.thiefsGloves,
      baseItem1: _sparringGloves,
      baseItem2: _sparringGloves,
    ),
    FullItemPreview(
      id: 44,
      name: _fullItemsTranslations.titansResolve.name,
      description: _fullItemsTranslations.titansResolve.description,
      asset: Assets.titansResolve,
      baseItem1: _chainVest,
      baseItem2: _recurveBow,
    ),
    FullItemPreview(
      id: 45,
      name: _fullItemsTranslations.warmogsArmor.name,
      description: _fullItemsTranslations.warmogsArmor.description,
      asset: Assets.warmogsArmor,
      baseItem1: _giantsBelt,
      baseItem2: _giantsBelt,
    ),
  ];

  static TranslationsPagesItemsDe get _translations =>
      Injector.instance.translations.pages.items;

  static TranslationsPagesItemsBaseDe get _baseItemsTranslations =>
      _translations.base;

  static TranslationsPagesItemsFullDe get _fullItemsTranslations =>
      _translations.full;
}
