import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/dialog.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';

class SettingsAdminDialog extends StatefulWidget {
  const SettingsAdminDialog._();

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) => const SettingsAdminDialog._(),
      );

  @override
  State<SettingsAdminDialog> createState() => _SettingsAdminDialogState();
}

class _SettingsAdminDialogState extends State<SettingsAdminDialog> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = colorScheme.surfaceContainerHighest;
    return Form(
      child: Builder(
        builder: (context) => CustomDialog(
          title: Text(_translations.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_translations.description),
              const SizedBox(height: 10),
              Pinput(
                autofocus: true,
                obscureText: true,
                textInputAction: TextInputAction.done,
                focusNode: _focusNode,
                controller: _controller,
                autofillHints: const [AutofillHints.password],
                length: 6,
                defaultPinTheme: _getPinTheme(
                  backgroundColor: backgroundColor,
                  borderColor: colorScheme.outlineVariant,
                ),
                submittedPinTheme: _getPinTheme(
                  backgroundColor: backgroundColor,
                  borderColor: colorScheme.secondary,
                ),
                focusedPinTheme: _getPinTheme(
                  backgroundColor: backgroundColor,
                  borderColor: colorScheme.primary,
                ),
                errorPinTheme: _getPinTheme(
                  backgroundColor: backgroundColor,
                  borderColor: Colors.transparent,
                ),
                errorTextStyle: TextStyle(color: colorScheme.error),
                validator: (pin) => _validator(context, pin),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validator(BuildContext context, String? pin) {
    switch (pin) {
      case null || '':
        return _translations.validator.empty;
      case String() when !Injector.instance.adminApi.checkPassword(pin):
        _controller.clear();
        return _translations.validator.wrong;
      case String():
        context
          ..read<BoolValueCubit>().update(true)
          ..pop();
        CustomSnackBar.showSuccess(context, _translations.enabled);
        return null;
    }
  }

  static PinTheme _getPinTheme({
    required Color backgroundColor,
    required Color borderColor,
  }) =>
      PinTheme(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: borderColor),
        ),
      );

  TranslationsPagesSettingsAdminEn get _translations =>
      Injector.instance.translations.pages.settings.admin;
}
