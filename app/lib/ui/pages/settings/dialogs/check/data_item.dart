import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/icon.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/item.dart';

class SettingsCheckDataItem<Bloc extends CheckDataBloc>
    extends StatelessWidget {
  const SettingsCheckDataItem({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SettingsCheckItem(
      icon: BlocBuilder<Bloc, CheckDataState>(
        builder: (context, state) => switch (state) {
          CheckDataInitial() => const SettingsCheckIcon.initial(),
          CheckDataLoadInProgress() => const SettingsCheckIcon.loading(),
          CheckDataLoadOnSuccess(:final success) when success =>
            const SettingsCheckIcon.success(),
          CheckDataLoadOnSuccess() => const SettingsCheckIcon.error(),
        },
      ),
      text: text,
    );
  }
}
