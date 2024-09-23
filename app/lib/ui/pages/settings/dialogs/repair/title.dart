import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/repair/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/icon.dart';

class SettingsRepairTitle extends StatelessWidget {
  const SettingsRepairTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_repairTranslations.name),
        BlocSelector<RepairBloc, RepairState, bool>(
          selector: (state) => state is RepairLoadOnFailure,
          builder: (context, isError) => switch (isError) {
            false => const SizedBox.shrink(),
            true => Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Tooltip(
                  message: _translations.general.errors.network,
                  child: const CustomIcon.warning(),
                ),
              ),
          },
        ),
      ],
    );
  }

  static Translations get _translations => Injector.instance.translations;

  static TranslationsPagesSettingsRepairEn get _repairTranslations =>
      _translations.pages.settings.repair;
}
