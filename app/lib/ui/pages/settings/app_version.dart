import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/admin/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';

class SettingsAppVersion extends StatelessWidget {
  const SettingsAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: GestureDetector(
          onTap: () => _onTap(context),
          child: Text(Injector.instance.packageInfo.version),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final cubit = context.read<AdminCubit>();
    if (cubit.state is AdminEnabled) {
      CustomSnackBar.showInfo(
        context,
        Injector.instance.translations.pages.settings.admin.alreadyEnabled,
      );
    } else {
      cubit.click();
    }
  }
}
