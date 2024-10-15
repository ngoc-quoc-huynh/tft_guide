part of 'cubit.dart';

typedef IntValueCubit = NumValueCubit<int>;
typedef CorrectAnswersCubit = IntValueCubit;

typedef NullableIntValueCubit = NumValueCubit<int?>;
typedef EloGainCubit = NullableIntValueCubit;

typedef BoolValueCubit = ValueCubit<bool>;
typedef AdminCubit = BoolValueCubit;

typedef NavigationBarValueCubit = ValueCubit<NavigationBarState>;
typedef ThemeModeValueCubit = ValueCubit<ThemeMode>;
typedef TranslationLocaleValueCubit = ValueCubit<TranslationLocale>;

typedef SelectedItemOptionValueCubit = SelectionValueCubit<QuestionItemOption>;
