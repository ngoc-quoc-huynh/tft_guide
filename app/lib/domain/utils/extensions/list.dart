import 'package:collection/collection.dart';
import 'package:tft_guide/injector.dart';

extension ListExtension<T> on List<T> {
  static final _random = Injector.instance.random;

  List<T> sampleWithoutElement(
    int count, {
    bool Function(T element)? ignore,
  }) =>
      switch (ignore) {
        null => sample(count, _random),
        final bool Function(T) ignore =>
          List.of(this..removeWhere(ignore)).sample(count, _random),
      };

  T random() {
    return this[_random.nextInt(length)];
  }
}
