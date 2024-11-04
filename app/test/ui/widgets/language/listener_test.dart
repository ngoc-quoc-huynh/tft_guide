import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';

import '../../../mocks.dart';

void main() {
  testWidgets('returns correctly.', (tester) async {
    final languageCodeValueCubit = MockLanguageCodeValueCubit();
    whenListen<LanguageCode>(
      languageCodeValueCubit,
      Stream.value(LanguageCode.de),
      initialState: LanguageCode.en,
    );
    await tester.pumpWidget(
      BlocProvider<LanguageCodeValueCubit>.value(
        value: languageCodeValueCubit,
        child: LanguageListener(
          onLanguageChanged: (languageCode) =>
              expect(languageCode, LanguageCode.de),
          child: const SizedBox.shrink(),
        ),
      ),
    );
  });
}
