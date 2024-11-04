import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/asset.dart';

void main() {
  group('call', () {
    test(
      'returns path.',
      () => expect(Asset('test.webp')(), 'test.webp'),
    );
  });
}
