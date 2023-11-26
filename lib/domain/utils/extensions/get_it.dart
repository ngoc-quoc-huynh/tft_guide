import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/items_repository.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';

extension GetItExtension on GetIt {
  ItemsRepository get itemsRepository => get<ItemsRepository>();

  Messages get messages => get<Messages>();
}
