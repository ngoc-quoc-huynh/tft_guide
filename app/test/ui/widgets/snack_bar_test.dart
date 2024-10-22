import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';

Future<void> main() async {
  const constraints = BoxConstraints(maxHeight: 100, minWidth: 120);
  await goldenTest(
    'CustomSnackBar renders correctly',
    fileName: 'snack_bar',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          constraints: constraints,
          name: 'Success',
          child: _TestWidget(
            (context) => CustomSnackBar.showSuccess(context, 'Success'),
          ),
        ),
        GoldenTestScenario(
          constraints: constraints,
          name: 'Info',
          child: _TestWidget(
            (context) => CustomSnackBar.showInfo(context, 'Info'),
          ),
        ),
      ],
    ),
  );
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget(this.showSnackBar);

  final void Function(BuildContext) showSnackBar;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme(const TextTheme()),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => showSnackBar(context));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
