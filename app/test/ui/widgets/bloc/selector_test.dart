import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/ui/widgets/bloc/selector.dart';

import '../../../utils.dart';

void main() {
  const type = BlocSelectorWithChild<IntValueCubit, int, int>;

  testWidgets('rebuilds child when state changes.', (tester) async {
    final key = GlobalKey<CountRebuildsWidgetState>();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<IntValueCubit>(
          create: (_) => IntValueCubit(0),
          child: BlocSelectorWithChild<IntValueCubit, int, int>(
            selector: (state) => state,
            builder: (context, state, _) => CountRebuildsWidget(key: key),
          ),
        ),
      ),
    );
    expect(key.currentState?.buildCount, 1);

    tester.readBloc<IntValueCubit>(type).increase();
    await tester.pump();
    expect(key.currentState?.buildCount, 2);
  });

  testWidgets('builds child once if state changes.', (tester) async {
    final key = GlobalKey<CountRebuildsWidgetState>();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<IntValueCubit>(
          create: (_) => IntValueCubit(0),
          child: BlocSelectorWithChild<IntValueCubit, int, int>(
            selector: (state) => state,
            builder: (context, state, child) => child!,
            child: CountRebuildsWidget(key: key),
          ),
        ),
      ),
    );
    expect(key.currentState?.buildCount, 1);

    tester.readBloc<IntValueCubit>(type).increase();
    await tester.pump();
    expect(key.currentState?.buildCount, 1);
  });
}
