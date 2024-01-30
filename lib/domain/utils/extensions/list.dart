import 'package:collection/collection.dart';

extension ListExtension<T> on List<T> {
  List<T> sampleWithoutElement(
    int count, {
    bool Function(T element)? ignore,
  }) =>
      switch (ignore) {
        null => sample(count),
        final bool Function(T) ignore =>
          List.of(this..removeWhere(ignore)).sample(count),
      };
}
