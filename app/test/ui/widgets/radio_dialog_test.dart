import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/dialog.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/option.dart';

import '../../mocks.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  final cubit = MockValueCubit<int>();
  whenListen<int>(
    cubit,
    const Stream<int>.empty(),
    initialState: 1,
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'radio_dialog',
    builder: () => BlocProvider<ValueCubit<int>>.value(
      value: cubit,
      child: const RadioDialog<int>(
        title: 'Test',
        options: [
          RadioDialogOption(
            title: '1',
            value: 1,
          ),
          RadioDialogOption(
            title: '2',
            value: 2,
          ),
        ],
      ),
    ),
  );
}
