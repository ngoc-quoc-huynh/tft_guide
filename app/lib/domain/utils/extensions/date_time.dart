extension DateTimeExtension on DateTime {
  static DateTime? tryParseOrNull(String? formattedString) =>
      switch (formattedString) {
        null => null,
        String() => DateTime.tryParse(formattedString),
      };

  bool get isToday {
    final date = toUtc();
    final today = DateTime.now().toUtc();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }
}
