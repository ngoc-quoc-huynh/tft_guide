import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/rank/division.dart';

void main() {
  test('returns correctly', () {
    expect(Division.one.name, 'I');
    expect(Division.two.name, 'II');
    expect(Division.three.name, 'III');
    expect(Division.four.name, 'IV');
  });
}
