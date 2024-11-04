import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';

class SettingsUpdateEloDialog extends StatelessWidget {
  const SettingsUpdateEloDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final elo = await showDialog<int>(
      context: context,
      useRootNavigator: false,
      builder: (context) => const SettingsUpdateEloDialog(),
    );
    if (context.mounted && elo != null) {
      context.read<HydratedEloCubit>().update(elo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (context) => CustomAlertDialog(
          title: _translations.name,
          content: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_translations.description),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: _translations.hint,
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validator,
                  onSaved: (value) => _onSaved(context, value!),
                  onFieldSubmitted: (_) => _onPressed(context),
                ),
              ],
            ),
          ),
          actions: [
            const AlertDialogAction.cancel(),
            AlertDialogAction.custom(
              text: _translations.button,
              onPressed: () => _onPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  static String? _validator(String? value) => switch (value?.trim()) {
        null || '' => _translations.validator,
        _ => null,
      };

  static void _onPressed(BuildContext context) {
    final form = Form.of(context);
    if (form.validate()) {
      form.save();
    }
  }

  static void _onSaved(BuildContext context, String value) =>
      context.pop(int.parse(value));

  static TranslationsPagesSettingsUpdateEloEn get _translations =>
      Injector.instance.translations.pages.settings.updateElo;
}
