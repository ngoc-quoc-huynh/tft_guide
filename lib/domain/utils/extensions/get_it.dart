import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

extension GetItExtension on GetIt {
  ItemsAPI get itemsAPI => get<ItemsAPI>();

  Translations get translations => get<Translations>();
}
