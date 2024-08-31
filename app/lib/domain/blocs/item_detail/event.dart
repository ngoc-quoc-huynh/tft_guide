part of 'bloc.dart';

@immutable
sealed class ItemDetailEvent {
  const ItemDetailEvent();
}

final class ItemDetailInitializeEvent extends ItemDetailEvent {
  const ItemDetailInitializeEvent({
    required this.id,
    required this.brightness,
    required this.textTheme,
  });

  final String id;
  final Brightness brightness;
  final TextTheme textTheme;
}

final class ItemDetailUpdateThemeDataEvent extends ItemDetailEvent {
  const ItemDetailUpdateThemeDataEvent({
    required this.brightness,
    required this.textTheme,
  });

  final Brightness brightness;
  final TextTheme textTheme;
}

final class ItemDetailUpdateLanguageCodeEvent extends ItemDetailEvent {
  const ItemDetailUpdateLanguageCodeEvent(this.languageCode);

  final LanguageCode languageCode;
}
