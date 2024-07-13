import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';

void main() {
  group('MyApp', () {
    setUpAll(Injector.setupDependencies);

    test('Example test', () => expect(true, true));
  });
}
