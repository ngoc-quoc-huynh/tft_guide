import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/repair/bloc.dart';
import 'package:tft_guide/injector.dart';

class SettingsRepairStartButton extends StatelessWidget {
  const SettingsRepairStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairBloc, RepairState>(
      builder: (context, state) => FilledButton(
        onPressed: _onPressed(context, state),
        child: switch (state) {
          RepairInitial() ||
          RepairLoadInProgress() ||
          RepairAnimationInProgress() =>
            Text(
              Injector.instance.translations.pages.settings.repair.button,
            ),
          RepairAnimationInProgress() ||
          RepairLoadOnSuccess() =>
            const Icon(Icons.check),
        },
      ),
    );
  }

  VoidCallback? _onPressed(
    BuildContext context,
    RepairState state,
  ) =>
      switch (state) {
        RepairInitial() => () =>
            context.read<RepairBloc>().add(const RepairStartEvent()),
        RepairLoadInProgress() || RepairAnimationInProgress() => null,
        RepairLoadOnSuccess() => () => context.pop(),
      };
}
