import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:tft_guide/infrastructure/repositories/local_file_storage.dart';
import 'package:tft_guide/static/resources/icons.dart';
import 'package:tft_guide/ui/widgets/item_detail/card.dart';

import 'robot.dart';

extension type ItemMetasPageRobot(WidgetTester _tester) implements Robot {
  Future<void> openTab() async {
    await _tester.tap(find.byIcon(Icons.format_list_bulleted));
    await _tester.pumpAndSettle();
  }

  Future<void> openBaseItemPage() async {
    final bfSword = find.text('B.F. Sword');
    expect(bfSword, findsOneWidget);
    expect(
      find.image(
        FileImage(
          File(
            join(
              LocalFileStorageRepository.assetsDir.path,
              'bf_sword.webp',
            ),
          ),
        ),
      ),
      findsOneWidget,
    );
    await _tester.tap(find.text('B.F. Sword'));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyBaseItemPage() async {
    final bfSword = find.text('B.F. Sword');
    expect(bfSword, findsOneWidget);
    _verifyFileImage('bf_sword');
    await _tester.tap(bfSword);
    await _tester.pumpAndSettle();
    expect(find.text('B.F. Sword'), findsOneWidget);
    _verifyFileImage('bf_sword');
    expect(find.byType(ItemDetailCard), findsNWidgets(3));
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Hint'), findsOneWidget);
    final attackDamage = find.byIcon(TftIcons.attackDamage);
    expect(attackDamage, findsOneWidget);
    await _tester.pumpAndSettle();
    expect(find.byTooltip('Attack damage'), findsOneWidget);
    await _tester.tap(find.byType(BackButton));
    await _tester.pumpAndSettle();
  }

  Future<void> openFullItemPage() async {
    final warmogsArmor = find.text("Warmog's Armor");
    await _tester.scrollUntilVisible(warmogsArmor, 50);
    await _tester.pumpAndSettle();
    expect(warmogsArmor, findsOneWidget);
    _verifyFileImage('warmogs_armor');
    await _tester.tap(warmogsArmor);
    await _tester.pumpAndSettle();
  }

  Future<void> verifyFullItemPage() async {
    expect(find.text("Warmog's Armor"), findsOneWidget);
    _verifyFileImage('warmogs_armor');
    expect(find.byType(ItemDetailCard), findsNWidgets(4));
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Hint'), findsOneWidget);
    expect(find.text('Combined by'), findsOneWidget);
    final health = find.byIcon(TftIcons.health);
    expect(health, findsOneWidget);
    expect(find.byTooltip('Health'), findsOneWidget);
    final giantsBelt = _verifyFileImage(
      'giants_belt',
      findsNWidgets(2),
    );
    expect(find.byTooltip('Item 1'), findsOneWidget);
    expect(find.byTooltip('Item 2'), findsOneWidget);
    await _tester.tap(giantsBelt.first);
    await _tester.pumpAndSettle();
    expect(find.text("Giant's Belt"), findsOneWidget);
  }

  Future<void> goBackToItemMetasPage() async {
    await _tester.tap(find.byType(BackButton));
    await _tester.pumpAndSettle();
    await _tester.tap(find.byType(BackButton));
    await _tester.pumpAndSettle();
  }

  Finder _verifyFileImage(
    String name, [
    Matcher matcher = findsOneWidget,
  ]) {
    final finder = find.image(
      FileImage(
        File(
          join(
            LocalFileStorageRepository.assetsDir.path,
            '$name.webp',
          ),
        ),
      ),
    );
    expect(finder, matcher);
    return finder;
  }
}
