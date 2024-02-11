import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

final class MasonMakeRankedBloc
    extends Bloc<MasonMakeRankedEvent, MasonMakeRankedState> {
  MasonMakeRankedBloc() : super(const MasonMakeRankedLoadInProgress()) {
    on<MasonMakeRankedInitializeEvent>(_onMasonMakeRankedInitializeEvent);
  }

  void _onMasonMakeRankedInitializeEvent(
    MasonMakeRankedInitializeEvent event,
    Emitter<MasonMakeRankedState> emit,
  ) {
    // TODO: Implement body
  }
}
