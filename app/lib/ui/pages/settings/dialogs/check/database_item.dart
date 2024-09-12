import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_database/bloc.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/icon.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/item.dart';

class SettingsCheckDatabaseItem<Bloc extends CheckDatabaseBloc>
    extends StatelessWidget {
  const SettingsCheckDatabaseItem({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SettingsCheckItem(
      icon: BlocBuilder<Bloc, CheckDatabaseState>(
        builder: (context, state) => switch (state) {
          CheckDatabaseInitial() => const SettingsCheckIcon.initial(),
          CheckDatabaseLoadInProgress() => const SettingsCheckIcon.loading(),
          CheckDatabaseLoadOnSuccess(:final success) when success =>
            const SettingsCheckIcon.success(),
          CheckDatabaseLoadOnSuccess() => const SettingsCheckIcon.error(),
        },
      ),
      text: text,
    );
  }
}
