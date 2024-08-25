import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/question_item.dart';
import 'package:tft_guide/injector.dart';

part 'base_item/bloc.dart';
part 'base_item/state.dart';
part 'event.dart';
part 'full_item/bloc.dart';
part 'full_item/state.dart';
part 'state.dart';

final class QuestionItemBloc<Item extends QuestionItem>
    extends Bloc<QuestionItemEvent, QuestionItemState> {
  QuestionItemBloc(this._loadQuestionItem)
      : super(const QuestionItemLoadInProgress()) {
    on<QuestionItemInitializeEvent>(_onQuestionItemInitializeEvent);
  }

  final Future<QuestionItem> Function(String, LanguageCode) _loadQuestionItem;
  @protected
  static final localDatabaseAPI = Injector.instance.localDatabaseAPI;

  Future<void> _onQuestionItemInitializeEvent(
    QuestionItemInitializeEvent event,
    Emitter<QuestionItemState> emit,
  ) async {
    final item = await _loadQuestionItem(
      event.id,
      Injector.instance.languageCode,
    );
    emit(QuestionItemLoadOnSuccess<Item>(item));
  }
}
