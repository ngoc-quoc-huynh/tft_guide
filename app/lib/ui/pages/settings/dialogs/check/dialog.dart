import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/button.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/data_item.dart';
import 'package:tft_guide/ui/widgets/dialog.dart';

class SettingsCheckDialog extends StatelessWidget {
  const SettingsCheckDialog._();

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (context) => const SettingsCheckDialog._(),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckAssetsBloc>(
          create: (_) => CheckAssetsBloc(),
        ),
        BlocProvider<CheckBaseItemsBloc>(
          create: (_) => CheckBaseItemsBloc(),
        ),
        BlocProvider<CheckFullItemsBloc>(
          create: (_) => CheckFullItemsBloc(),
        ),
        BlocProvider<CheckPatchNotesBloc>(
          create: (_) => CheckPatchNotesBloc(),
        ),
      ],
      child: CustomDialog(
        title: _translations.name,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_translations.description),
            const SizedBox(height: 10),
            SettingsCheckDataItem<CheckAssetsBloc>(
              text: _translations.assets,
            ),
            const SizedBox(height: 5),
            SettingsCheckDataItem<CheckBaseItemsBloc>(
              text: _translations.baseItems,
            ),
            const SizedBox(height: 5),
            SettingsCheckDataItem<CheckFullItemsBloc>(
              text: _translations.fullItems,
            ),
            const SizedBox(height: 5),
            SettingsCheckDataItem<CheckPatchNotesBloc>(
              text: _translations.patchNotes,
            ),
          ],
        ),
        action: const SettingsCheckStartButton(),
      ),
    );
  }

  TranslationsPagesSettingsCheckEn get _translations =>
      Injector.instance.translations.pages.settings.check;
}
