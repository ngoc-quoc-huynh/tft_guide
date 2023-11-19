import 'package:get_it/get_it.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';

extension GetItExtension on GetIt {
  Messages get messages => get<Messages>();
}
