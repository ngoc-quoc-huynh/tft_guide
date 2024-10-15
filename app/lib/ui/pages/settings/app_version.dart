import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/step_timer/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/config.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/admin.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';

class SettingsAppVersion extends StatelessWidget {
  const SettingsAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StepTimerCubit>(
      create: (_) => StepTimerCubit(Config.amountOfStepsToEnableAdmin),
      child: BlocListener<StepTimerCubit, StepTimerState>(
        listener: _onStepTimerStateChanged,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1,
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () => _onTap(context),
                child: Text(Injector.instance.packageInfo.version),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) =>
      switch (context.read<AdminCubit>().state) {
        false => context.read<StepTimerCubit>().advance(),
        true => CustomSnackBar.showInfo(
            context,
            Injector.instance.translations.pages.settings.admin.alreadyEnabled,
          ),
      };

  void _onStepTimerStateChanged(BuildContext context, StepTimerState state) =>
      switch (state) {
        StepTimerInitial() => null,
        StepTimerCompleted() => unawaited(
            SettingsAdminDialog.show(context),
          ),
        StepTimerInProgress(:final step) when step >= 3 =>
          CustomSnackBar.showInfo(
            context,
            Injector.instance.translations.pages.settings.admin.inProgress(
              steps: Config.amountOfStepsToEnableAdmin - step,
            ),
          ),
        StepTimerInProgress() => null,
      };
}
