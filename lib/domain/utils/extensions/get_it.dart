import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';

extension GetItExtension on GetIt {
  ItemsAPI get itemsAPI => get<ItemsAPI>();

  Messages get messages => get<Messages>();
}
