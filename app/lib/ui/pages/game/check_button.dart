import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/correct_answers/cubit.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/injector.dart';
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
        child: BlocListener<CheckSelectedItemOptionCubit, bool?>(
          listener: _onCheckSelectedItemStateChanged,
          child:
              BlocSelector<SelectedItemOptionCubit, QuestionItemOption?, bool>(
            selector: (state) => state != null,
            builder: (context, hasSelected) => FilledButton(
              onPressed: switch (hasSelected) {
                true => () => context
                    .read<CheckSelectedItemOptionCubit>()
                    .check(context.read<SelectedItemOptionCubit>().state!),
                false => null
              },
              child: Text(Injector.instance.translations.pages.game.check),
            ),
          ),
        ),
      ),
    );
  }

  void _onCheckSelectedItemStateChanged(BuildContext context, bool? isCorrect) {
    if (isCorrect != null) {
      if (isCorrect) {
        context.read<CorrectAnswersCubit>().increase();
      }
      unawaited(FeedbackBottomSheet.show(context, isCorrect: isCorrect));
    }
  }
}
