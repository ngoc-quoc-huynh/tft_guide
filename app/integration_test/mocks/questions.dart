import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';

// ignore_for_file: avoid-non-ascii-symbols, since they are test data.

final class MockQuestionsApi implements QuestionsApi {
  const MockQuestionsApi();

  @override
  Future<List<Question>> generateBaseItemQuestions({
    required int amount,
    required int otherOptionsAmount,
    required LanguageCode languageCode,
  }) async =>
      const [
        TitleTextQuestion(
          correctOption: _bfSword,
          otherOptions: <QuestionBaseItemOption>[
            _chainVest,
            _giantsBelt,
          ],
        ),
        TitleImageQuestion(
          correctOption: _chainVest,
          otherOptions: <QuestionBaseItemOption>[
            _giantsBelt,
            _spatula,
          ],
        ),
        DescriptionTextQuestion(
          correctOption: _giantsBelt,
          otherOptions: <QuestionBaseItemOption>[
            _spatula,
            _bfSword,
          ],
        ),
        DescriptionImageQuestion(
          correctOption: _spatula,
          otherOptions: <QuestionBaseItemOption>[
            _bfSword,
            _chainVest,
          ],
        ),
      ];

  @override
  Future<List<Question>> generateFullItemQuestions({
    required int amount,
    required int otherOptionsAmount,
    required LanguageCode languageCode,
  }) async =>
      const [
        BaseItemsTextQuestion(
          correctOption: _brambleVest,
          otherOptions: [
            _edgeOfNight,
            _sunfireCape,
          ],
        ),
        BaseItemsImageQuestion(
          correctOption: _deathblade,
          otherOptions: [
            _edgeOfNight,
            _steraksGage,
          ],
        ),
        FullItemTextQuestion(
          correctOption: _edgeOfNight,
          otherOptions: [
            _brambleVest,
            _sunfireCape,
          ],
        ),
        FullItemImageQuestion(
          correctOption: _steraksGage,
          otherOptions: [
            _deathblade,
            _edgeOfNight,
          ],
        ),
        TitleTextQuestion(
          correctOption: _tacticiansCrown,
          otherOptions: <QuestionFullItemOption>[
            _brambleVest,
            _warmogsArmor,
          ],
        ),
        DescriptionTextQuestion(
          correctOption: _warmogsArmor,
          otherOptions: <QuestionFullItemOption>[
            _sunfireCape,
            _steraksGage,
          ],
        ),
      ];

  static const _bfSword = QuestionBaseItemOption(
    id: 'bf_sword',
    name: 'B.F. Sword',
    description: 'Grants 10% attack damage (AD).',
  );
  static const _chainVest = QuestionBaseItemOption(
    id: 'chain_vest',
    name: 'Chain Vest',
    description: 'Grants 20 armor.',
  );
  static const _giantsBelt = QuestionBaseItemOption(
    id: 'giants_belt',
    name: "Giant's Belt",
    description: 'Grants 150 health points (HP).',
  );
  static const _spatula = QuestionBaseItemOption(
    id: 'spatula',
    name: 'Spatula',
    description: 'It must do something …',
  );

  static const _brambleVest = QuestionFullItemOption(
    id: 'spatula',
    name: 'Bramble Vest',
    description:
        'Grants 5% max HP and receives 8% less AD damage. When you are '
        'attacked, all adjacent enemies take 100 AP damage.',
    isSpecial: false,
    itemId1: 'chain_vest',
    itemId2: 'chain_vest',
  );
  static const _deathblade = QuestionFullItemOption(
    id: 'deathblade',
    name: 'Deathblade',
    description: 'Deal 7% bonus damage.',
    isSpecial: false,
    itemId1: 'bf_sword',
    itemId2: 'bf_sword',
  );
  static const _edgeOfNight = QuestionFullItemOption(
    id: 'edge_of_night',
    name: 'Edge of Night',
    description:
        'DAt 60% Health, briefly become untargetable and shed negative effects.'
        ' Then, gain 15% attack speed.',
    isSpecial: false,
    itemId1: 'bf_sword',
    itemId2: 'chain_vest',
  );
  static const _steraksGage = QuestionFullItemOption(
    id: 'steraks_gage',
    name: "Sterak's Gage",
    description: 'Grants 25% max HP and 35% attack damage at 60% HP.',
    isSpecial: false,
    itemId1: 'bf_sword',
    itemId2: 'giants_belt',
  );
  static const _sunfireCape = QuestionFullItemOption(
    id: 'sunfire_cape',
    name: 'Sunfire Cape',
    description:
        'Every 2 seconds, inflict 1% burn on an enemy within 2 hexes and reduce'
        ' healing by 33% for 10 seconds.',
    isSpecial: false,
    itemId1: 'giants_belt',
    itemId2: 'chain_vest',
  );
  static const _tacticiansCrown = QuestionFullItemOption(
    id: 'tacticians_crown',
    name: "Tactician's Crown",
    description: 'Your team gains +1 max team size.',
    isSpecial: false,
    itemId1: 'giants_belt',
    itemId2: 'chain_vest',
  );
  static const _warmogsArmor = QuestionFullItemOption(
    id: 'warmogs_armor',
    name: "Warmog's Armor",
    description: 'Grants 8% max HP.',
    isSpecial: false,
    itemId1: 'giants_belt',
    itemId2: 'chain_vest',
  );
}
