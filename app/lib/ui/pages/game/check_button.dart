import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_selected_option/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';
import 'package:tft_guide/ui/widgets/bloc/selector.dart';

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
        child: BlocListener<CheckSelectedItemOptionCubit, bool?>(
          listener: _onCheckSelectedItemStateChanged,
          child: BlocSelectorWithChild<SelectedItemOptionValueCubit,
              QuestionItemOption?, bool>(
            selector: (state) => state != null,
            builder: (context, hasSelected, child) => FilledButton(
              onPressed: switch (hasSelected) {
                true => () => context
                    .read<CheckSelectedItemOptionCubit>()
                    .check(context.read<SelectedItemOptionValueCubit>().state!),
                false => null
              },
              child: child,
            ),
            child: Text(Injector.instance.translations.pages.game.check),
          ),
        ),
      ),
    );
  }

  void _onCheckSelectedItemStateChanged(BuildContext context, bool? isCorrect) {
    if (isCorrect != null) {
      if (isCorrect) {
        context.read<IntValueCubit>().increase();
      }
      unawaited(FeedbackBottomSheet.show(context, isCorrect: isCorrect));
    }
  }
}
