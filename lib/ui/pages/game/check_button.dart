import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.verticalPadding / 2,
        bottom: Sizes.verticalPadding,
      ),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: BlocListener<CheckSelectedItemCubit, bool?>(
          listener: _onCheckSelectedItemStateChanged,
          child: BlocSelector<SelectedItemCubit, Item?, bool>(
            selector: (state) => state != null,
            builder: (context, hasSelected) => FilledButton(
              onPressed: switch (hasSelected) {
                true => () => context
                    .read<CheckSelectedItemCubit>()
                    .check(context.read<SelectedItemCubit>().state!),
                false => null
              },
              child: const Text('Check'),
            ),
          ),
        ),
      ),
    );
  }

  void _onCheckSelectedItemStateChanged(BuildContext context, bool? isCorrect) {
    if (isCorrect != null) {
      unawaited(FeedbackBottomSheet.show(context));
    }
  }
}
