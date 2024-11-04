import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/ui/widgets/language/builder.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  testWidgets('rebuilds correctly', (tester) async {
    final languageCodeValueCubit = MockLanguageCodeValueCubit();
    whenListen<LanguageCode>(
      languageCodeValueCubit,
      Stream.value(LanguageCode.de),
      initialState: LanguageCode.en,
    );
    final key = GlobalKey<CountRebuildsWidgetState>();
    await tester.pumpWidget(
      BlocProvider<LanguageCodeValueCubit>.value(
        value: languageCodeValueCubit,
        child: LanguageBuilder(
          builder: (context) => Directionality(
            textDirection: TextDirection.ltr,
            child: CountRebuildsWidget(key: key),
          ),
        ),
      ),
    );
    expect(key.currentState?.buildCount, 1);
  });
}
