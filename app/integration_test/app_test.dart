import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'injector.dart';
import 'robots/game.dart';
import 'robots/item_metas.dart';
import 'robots/patch_notes.dart';
import 'robots/settings.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(TestInjector.setUp);

  tearDown(TestInjector.tearDown);

  testWidgets(
    'renders GamePage correctly.',
    (tester) async {
      final robot = GamePageRobot(tester);
      await robot.initApp();
      robot.verifyInitialScreen();
      await robot.startGame();
      await robot.checkSelectionItem(0, isCorrect: true);
      await robot.checkSelectionItem(1, isCorrect: true);
      await robot.checkSelectionItem(2, isCorrect: false);
      await robot.checkSelectionItem(0, isCorrect: true);
      await robot.checkSelectionItem(1, isCorrect: false);
      await robot.checkSelectionItem(2, isCorrect: false);
      await robot.checkSelectionItem(0, isCorrect: false);
      await robot.checkSelectionItem(1, isCorrect: true);
      await robot.checkSelectionItem(2, isCorrect: false);
      await robot.checkSelectionItem(0, isCorrect: false);
      await robot.verifyEndScreen();
    },
  );

  testWidgets('renders SettingsPage correctly.', (tester) async {
    final robot = SettingsPageRobot(tester);
    await robot.initApp();
    await robot.openSettings();
    await robot.verifyAppUpdateDialog();
    await robot.verifyDesignDialog();
    await robot.verifyLanguageDialog();
    await robot.verifyCheckDialog();
    await robot.verifyRepairDialog();
    await robot.verifyResetDialog();
    await robot.verifyFeedbackDialog();
    await robot.verifyLicensePage();
    await robot.verifyAdminDialog();
    await robot.verifyUpdateEloDialog();
    await robot.goBackToRankedPage();
  });

  testWidgets('renders ItemMetasPage correctly.', (tester) async {
    final robot = ItemMetasPageRobot(tester);
    await robot.initApp();
    await robot.openTab();
    await robot.openBaseItemPage();
    await robot.verifyBaseItemPage();
    await robot.openFullItemPage();
    await robot.verifyFullItemPage();
    await robot.goBackToItemMetasPage();
  });

  testWidgets('renders PatchNotesPage correctly.', (tester) async {
    final robot = PatchNotesPageRobot(tester);
    await robot.initApp();
    await robot.openTab();
    robot.verifyScreen();
  });
}
