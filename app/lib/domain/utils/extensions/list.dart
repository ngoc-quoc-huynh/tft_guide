import 'package:collection/collection.dart';
import 'package:tft_guide/injector.dart';

extension ListExtension<T> on List<T> {
  static final _random = Injector.instance.random;

  T get random => this[_random.nextInt(length)];

  List<T> sampleWithoutElement(
    int count, {
    bool Function(T element)? ignore,
  }) {
    assert(count > 0, 'count must be greater than 0.');

    return switch (ignore) {
      null => sample(count, _random),
      final bool Function(T) ignore =>
        List.of(this..removeWhere(ignore)).sample(count, _random),
    };
  }
}
