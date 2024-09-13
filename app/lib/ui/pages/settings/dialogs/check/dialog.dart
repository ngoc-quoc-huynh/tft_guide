import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/button.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/data_item.dart';

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
      child: AlertDialog(
        shape: _shape,
        titlePadding: _titlePadding,
        title: Row(
          children: [
            Text(_translations.name),
            const Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: CloseButton(),
              ),
            ),
          ],
        ),
        contentPadding: _contentPadding,
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
        actionsPadding: _actionsPadding,
        actionsAlignment: MainAxisAlignment.center,
        actions: const [
          SettingsCheckStartButton(),
        ],
      ),
    );
  }

  // TODO: Extract
  static const _titlePadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    left: Sizes.horizontalPadding,
  );
  static const _contentPadding = EdgeInsets.only(
    top: Sizes.verticalPadding / 2,
    bottom: Sizes.verticalPadding / 2,
    right: Sizes.horizontalPadding,
    left: Sizes.horizontalPadding,
  );
  static const _actionsPadding = EdgeInsets.only(
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
    bottom: Sizes.verticalPadding / 2,
  );
  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  TranslationsPagesSettingsCheckEn get _translations =>
      Injector.instance.translations.pages.settings.check;
}
