import 'package:clock/clock.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static DateTime? tryParseOrNull(String? formattedString) =>
      switch (formattedString) {
        null => null,
        String() => DateTime.tryParse(formattedString),
      };

  bool get isToday {
    final date = toUtc();
    final today = clock.now().toUtc();

    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  String format() => _format.format(this);

  static final _format = DateFormat('dd.MM.yy');
}
