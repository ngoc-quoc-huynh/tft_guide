import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/utils/extensions/bloc.dart';

void main() {
  group('debounce', () {
    blocTest<_DebounceBloc, int>(
      'process only the first event within 300 milliseconds.',
      build: _DebounceBloc.new,
      act: (bloc) => bloc
        ..add(1)
        ..add(2)
        ..add(3),
      wait: const Duration(milliseconds: 300),
      expect: () => [1],
    );

    blocTest<_DebounceBloc, int>(
      'processes events after debounce time has passed.',
      build: _DebounceBloc.new,
      act: (bloc) async {
        bloc.add(1);
        await Future<void>.delayed(const Duration(milliseconds: 400));
        bloc.add(2);
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [1, 2],
    );
  });
}

class _DebounceBloc extends Bloc<int, int> {
  _DebounceBloc() : super(0) {
    on<int>(
      (event, emit) => emit(event),
      transformer: debounce(),
    );
  }
}
