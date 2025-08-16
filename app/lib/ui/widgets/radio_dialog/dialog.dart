import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/option.dart';

class RadioDialog<T extends Object> extends StatelessWidget {
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
      content: BlocBuilder<ValueCubit<T>, T>(
        builder: (context, option) => RadioGroup<T>(
          groupValue: option,
          onChanged: (value) => context.read<ValueCubit<T>>().update(value!),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options,
          ),
        ),
      ),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(
          result: () => context.read<ValueCubit<T>>().state,
        ),
      ],
    );
  }
}
