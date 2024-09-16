import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/icon.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/item.dart';

class SettingsCheckDataItem<Bloc extends CheckDataBloc>
    extends StatelessWidget {
  const SettingsCheckDataItem({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SettingsCheckItem(
      icon: BlocBuilder<Bloc, CheckDataState>(
        builder: (context, state) => switch (state) {
          CheckDataInitial() => const SettingsCheckIcon.initial(),
          CheckDataLoadInProgress() => const SettingsCheckIcon.loading(),
          CheckAssetsLoadOnValid(:final localCount, :final remoteCount) =>
            SettingsCheckIcon.valid(
              message: _getCheckAssetsMessage(localCount, remoteCount),
            ),
          CheckAssetsLoadOnInvalid(:final localCount, :final remoteCount) =>
            SettingsCheckIcon.invalid(
              message: _getCheckAssetsMessage(localCount, remoteCount),
            ),
          CheckDatabaseLoadOnValid(
            :final localDataCount,
            :final remoteDataCount,
            :final localTranslationCount,
            :final remoteTranslationCount
          ) =>
            SettingsCheckIcon.valid(
              message: _getCheckDatabaseMessage(
                localDataCount,
                remoteDataCount,
                localTranslationCount,
                remoteTranslationCount,
              ),
            ),
          CheckDatabaseLoadOnInvalid(
            :final localDataCount,
            :final remoteDataCount,
            :final localTranslationCount,
            :final remoteTranslationCount
          ) =>
            SettingsCheckIcon.invalid(
              message: _getCheckDatabaseMessage(
                localDataCount,
                remoteDataCount,
                localTranslationCount,
                remoteTranslationCount,
              ),
            ),
          CheckDataLoadOnFailure() => const SettingsCheckIcon.error(),
        },
      ),
      text: text,
    );
  }

  static String _getCheckAssetsMessage(
    int localCount,
    int remoteCount,
  ) =>
      _translations.assets.check(
        localCount: localCount,
        remoteCount: remoteCount,
      );

  String _getCheckDatabaseMessage(
    int localDataCount,
    int remoteDataCount,
    int localTranslationCount,
    int remoteTranslationCount,
  ) {
    if (Bloc == CheckBaseItemsBloc) {
      return '${_translations.baseItems.checkItems(
        localCount: localDataCount,
        remoteCount: remoteDataCount,
      )}\n${_translations.baseItems.checkTranslations(
        localCount: localTranslationCount,
        remoteCount: remoteTranslationCount,
      )}';
    } else if (Bloc == CheckFullItemsBloc) {
      return '${_translations.fullItems.checkItems(
        localCount: localDataCount,
        remoteCount: remoteDataCount,
      )}\n${_translations.fullItems.checkTranslations(
        localCount: localTranslationCount,
        remoteCount: remoteTranslationCount,
      )}';
    } else if (Bloc == CheckPatchNotesBloc) {
      return '${_translations.patchNotes.checkPatchNotes(
        localCount: localDataCount,
        remoteCount: remoteDataCount,
      )}\n${_translations.patchNotes.checkTranslations(
        localCount: localTranslationCount,
        remoteCount: remoteTranslationCount,
      )}';
    } else {
      throw ArgumentError('$Bloc is not a subtype of CheckDatabaseBloc.');
    }
  }

  static TranslationsPagesSettingsCheckEn get _translations =>
      Injector.instance.translations.pages.settings.check;
}
