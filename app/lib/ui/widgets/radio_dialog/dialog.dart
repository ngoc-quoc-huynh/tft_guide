import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/option.dart';

class RadioDialog<T> extends StatelessWidget {
  const RadioDialog({
    required this.title,
    required this.options,
    super.key,
  });

  final String title;
  final List<RadioDialogOption<T>> options;

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: options,
      ),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(
          onPressed: () => context.pop(
            context.read<ValueCubit<T>>().state,
          ),
        ),
      ],
    );
  }
}
