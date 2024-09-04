extension type Route(String name) {
  String call() => name;
}

final class Routes {
  const Routes._();

  static final baseItemsPage = Route('base-items');
  static final fullItemsPage = Route('full-items');
  static final gamePage = Route('game');
  static final itemMetasPage = Route('item-metas');
  static final rankedPage = Route('ranked');
  static final settingsPage = Route('settings');
  static final quotesPage = Route('quotes');
}
