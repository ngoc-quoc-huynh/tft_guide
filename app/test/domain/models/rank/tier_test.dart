import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';

void main() {
  test('returns correctly.', () {
    expect(Tier.iron.name, 'Iron');
    expect(Tier.bronze.name, 'Bronze');
    expect(Tier.silver.name, 'Silver');
    expect(Tier.gold.name, 'Gold');
    expect(Tier.platinum.name, 'Platinum');
    expect(Tier.emerald.name, 'Emerald');
    expect(Tier.diamond.name, 'Diamond');
    expect(Tier.master.name, 'Master');
    expect(Tier.grandmaster.name, 'Grandmaster');
    expect(Tier.challenger.name, 'Challenger');
  });
}
