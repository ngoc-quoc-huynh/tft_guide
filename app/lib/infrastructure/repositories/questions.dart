import 'package:collection/collection.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/models/question_item2.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/assets.dart';

final class QuestionsRepository implements QuestionsAPI {
  const QuestionsRepository();

  @override
  Future<List<QuestionBaseItem>> loadRandomQuestionBaseItems(
    int amount,
  ) async =>
      _baseItems.sample(amount);

  @override
  Future<List<QuestionFullItem>> loadRandomQuestionFullItems(
    int amount,
  ) async =>
      _fullItems.sample(amount);

  static final _bfSword = QuestionBaseItem(
    name: _baseItemsTranslations.bfSword.name,
    description: _baseItemsTranslations.bfSword.description,
    asset: Assets.bfSword,
  );
  static final _chainVest = QuestionBaseItem(
    name: _baseItemsTranslations.chainVest.name,
    description: _baseItemsTranslations.chainVest.description,
    asset: Assets.chainVest,
  );
  static final _giantsBelt = QuestionBaseItem(
    name: _baseItemsTranslations.giantsBelt.name,
    description: _baseItemsTranslations.giantsBelt.description,
    asset: Assets.giantsBelt,
  );
  static final _needlesslyLargeRod = QuestionBaseItem(
    name: _baseItemsTranslations.needlesslyLargeRod.name,
    description: _baseItemsTranslations.needlesslyLargeRod.description,
    asset: Assets.needlesslyLargeRod,
  );
  static final _negatronCloak = QuestionBaseItem(
    name: _baseItemsTranslations.negatronCloak.name,
    description: _baseItemsTranslations.negatronCloak.description,
    asset: Assets.negatronCloak,
  );
  static final _recurveBow = QuestionBaseItem(
    name: _baseItemsTranslations.recurveBow.name,
    description: _baseItemsTranslations.recurveBow.description,
    asset: Assets.recurveBow,
  );
  static final _sparringGloves = QuestionBaseItem(
    name: _baseItemsTranslations.sparringGloves.name,
    description: _baseItemsTranslations.sparringGloves.description,
    asset: Assets.sparringGloves,
  );
  static final _spatula = QuestionBaseItem(
    name: _baseItemsTranslations.spatula.name,
    description: _baseItemsTranslations.spatula.description,
    asset: Assets.spatula,
  );
  static final _tearOfTheGoddess = QuestionBaseItem(
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
    QuestionFullItem(
      name: _fullItemsTranslations.adaptiveHelm.name,
      description: _fullItemsTranslations.adaptiveHelm.description,
      asset: Assets.adaptiveHelm,
      baseItem1: _negatronCloak,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.archangelsStaff.name,
      description: _fullItemsTranslations.archangelsStaff.description,
      asset: Assets.archangelsStaff,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.bloodthirster.name,
      description: _fullItemsTranslations.bloodthirster.description,
      asset: Assets.bloodthirster,
      baseItem1: _bfSword,
      baseItem2: _negatronCloak,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.blueBuff.name,
      description: _fullItemsTranslations.blueBuff.description,
      asset: Assets.blueBuff,
      baseItem1: _tearOfTheGoddess,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.brambleVest.name,
      description: _fullItemsTranslations.brambleVest.description,
      asset: Assets.brambleVest,
      baseItem1: _chainVest,
      baseItem2: _chainVest,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.crownguard.name,
      description: _fullItemsTranslations.crownguard.description,
      asset: Assets.crownguard,
      baseItem1: _chainVest,
      baseItem2: _needlesslyLargeRod,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.deathblade.name,
      description: _fullItemsTranslations.deathblade.description,
      asset: Assets.deathblade,
      baseItem1: _bfSword,
      baseItem2: _bfSword,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.dragonsClaw.name,
      description: _fullItemsTranslations.dragonsClaw.description,
      asset: Assets.dragonsClaw,
      baseItem1: _negatronCloak,
      baseItem2: _negatronCloak,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.edgeOfNight.name,
      description: _fullItemsTranslations.edgeOfNight.description,
      asset: Assets.edgeOfNight,
      baseItem1: _bfSword,
      baseItem2: _chainVest,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.evenshroud.name,
      description: _fullItemsTranslations.evenshroud.description,
      asset: Assets.evenshroud,
      baseItem1: _giantsBelt,
      baseItem2: _negatronCloak,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.gargoyleStoneplate.name,
      description: _fullItemsTranslations.gargoyleStoneplate.description,
      asset: Assets.gargoyleStoneplate,
      baseItem1: _chainVest,
      baseItem2: _negatronCloak,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.giantSlayer.name,
      description: _fullItemsTranslations.giantSlayer.description,
      asset: Assets.giantSlayer,
      baseItem1: _bfSword,
      baseItem2: _recurveBow,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.guardbreaker.name,
      description: _fullItemsTranslations.guardbreaker.description,
      asset: Assets.guardbreaker,
      baseItem1: _giantsBelt,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.guinsoosRageblade.name,
      description: _fullItemsTranslations.guinsoosRageblade.description,
      asset: Assets.guinsoosRageblade,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _recurveBow,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.handOfJustice.name,
      description: _fullItemsTranslations.handOfJustice.description,
      asset: Assets.handOfJustice,
      baseItem1: _tearOfTheGoddess,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.hextechGunblade.name,
      description: _fullItemsTranslations.hextechGunblade.description,
      asset: Assets.hextechGunblade,
      baseItem1: _bfSword,
      baseItem2: _needlesslyLargeRod,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.infinityEdge.name,
      description: _fullItemsTranslations.infinityEdge.description,
      asset: Assets.infinityEdge,
      baseItem1: _bfSword,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.ionicSpark.name,
      description: _fullItemsTranslations.ionicSpark.description,
      asset: Assets.ionicSpark,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _negatronCloak,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.jeweledGauntlet.name,
      description: _fullItemsTranslations.jeweledGauntlet.description,
      asset: Assets.jeweledGauntlet,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.lastWhisper.name,
      description: _fullItemsTranslations.lastWhisper.description,
      asset: Assets.lastWhisper,
      baseItem1: _recurveBow,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.morellonomicon.name,
      description: _fullItemsTranslations.morellonomicon.description,
      asset: Assets.morellonomicon,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _giantsBelt,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.nashorsTooth.name,
      description: _fullItemsTranslations.nashorsTooth.description,
      asset: Assets.nashorsTooth,
      baseItem1: _giantsBelt,
      baseItem2: _recurveBow,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.protectorsVow.name,
      description: _fullItemsTranslations.protectorsVow.description,
      asset: Assets.protectorsVow,
      baseItem1: _chainVest,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.quicksilver.name,
      description: _fullItemsTranslations.quicksilver.description,
      asset: Assets.quicksilver,
      baseItem1: _negatronCloak,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.rabadonsDeathcap.name,
      description: _fullItemsTranslations.rabadonsDeathcap.description,
      asset: Assets.rabadonsDeathcap,
      baseItem1: _needlesslyLargeRod,
      baseItem2: _needlesslyLargeRod,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.redBuff.name,
      description: _fullItemsTranslations.redBuff.description,
      asset: Assets.redBuff,
      baseItem1: _recurveBow,
      baseItem2: _recurveBow,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.redemption.name,
      description: _fullItemsTranslations.redemption.description,
      asset: Assets.redemption,
      baseItem1: _giantsBelt,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.runaansHurricane.name,
      description: _fullItemsTranslations.runaansHurricane.description,
      asset: Assets.runaansHurricane,
      baseItem1: _negatronCloak,
      baseItem2: _recurveBow,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.spearOfShojin.name,
      description: _fullItemsTranslations.spearOfShojin.description,
      asset: Assets.spearOfShojin,
      baseItem1: _bfSword,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.statikkShiv.name,
      description: _fullItemsTranslations.statikkShiv.description,
      asset: Assets.statikkShiv,
      baseItem1: _recurveBow,
      baseItem2: _tearOfTheGoddess,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.steadfastHeart.name,
      description: _fullItemsTranslations.steadfastHeart.description,
      asset: Assets.steadfastHeart,
      baseItem1: _chainVest,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.steraksGage.name,
      description: _fullItemsTranslations.steraksGage.description,
      asset: Assets.steraksGage,
      baseItem1: _bfSword,
      baseItem2: _giantsBelt,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.sunfireCape.name,
      description: _fullItemsTranslations.sunfireCape.description,
      asset: Assets.sunfireCape,
      baseItem1: _giantsBelt,
      baseItem2: _chainVest,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.tacticiansCrown.name,
      description: _fullItemsTranslations.tacticiansCrown.description,
      asset: Assets.tacticiansCrown,
      baseItem1: _spatula,
      baseItem2: _spatula,
      isSpecial: true,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.thiefsGloves.name,
      description: _fullItemsTranslations.thiefsGloves.description,
      asset: Assets.thiefsGloves,
      baseItem1: _sparringGloves,
      baseItem2: _sparringGloves,
    ),
    QuestionFullItem(
      name: _fullItemsTranslations.titansResolve.name,
      description: _fullItemsTranslations.titansResolve.description,
      asset: Assets.titansResolve,
      baseItem1: _chainVest,
      baseItem2: _recurveBow,
    ),
    QuestionFullItem(
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
