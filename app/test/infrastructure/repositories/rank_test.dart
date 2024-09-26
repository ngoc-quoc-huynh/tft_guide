import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';

void main() {
  group('computeLp', () {
    test('returns correctly if elo is less than challenger one elo', () {
      expect(const LocalRankRepository().computeLp(0), 0);
      expect(const LocalRankRepository().computeLp(20), 20);
      expect(const LocalRankRepository().computeLp(150), 50);
      expect(const LocalRankRepository().computeLp(2201), 1);
    });

    test('returns correctly if elo is greater than challenger one elo', () {
      expect(const LocalRankRepository().computeLp(3900), 0);
      expect(const LocalRankRepository().computeLp(4000), 100);
      expect(const LocalRankRepository().computeLp(4500), 600);
    });
  });

  group('computeRank', () {
    group('Iron', () {
      test('returns Iron 4 if elo is less than 100.', () {
        expect(
          const LocalRankRepository().computeRank(0),
          LocalRankRepository.iron4,
        );
        expect(
          const LocalRankRepository().computeRank(50),
          LocalRankRepository.iron4,
        );
        expect(
          const LocalRankRepository().computeRank(99),
          LocalRankRepository.iron4,
        );
      });

      test('returns Iron 3 if elo is between 100 and 199.', () {
        expect(
          const LocalRankRepository().computeRank(100),
          LocalRankRepository.iron3,
        );
        expect(
          const LocalRankRepository().computeRank(150),
          LocalRankRepository.iron3,
        );
        expect(
          const LocalRankRepository().computeRank(199),
          LocalRankRepository.iron3,
        );
      });

      test('returns Iron 2 if elo is between 200 and 299.', () {
        expect(
          const LocalRankRepository().computeRank(200),
          LocalRankRepository.iron2,
        );
        expect(
          const LocalRankRepository().computeRank(250),
          LocalRankRepository.iron2,
        );
        expect(
          const LocalRankRepository().computeRank(299),
          LocalRankRepository.iron2,
        );
      });

      test('returns Iron 1 if elo is between 300 and 399.', () {
        expect(
          const LocalRankRepository().computeRank(300),
          LocalRankRepository.iron1,
        );
        expect(
          const LocalRankRepository().computeRank(350),
          LocalRankRepository.iron1,
        );
        expect(
          const LocalRankRepository().computeRank(399),
          LocalRankRepository.iron1,
        );
      });
    });

    group('Bronze', () {
      test('returns Bronze 4 if elo is between 400 and 499.', () {
        expect(
          const LocalRankRepository().computeRank(400),
          LocalRankRepository.bronze4,
        );
        expect(
          const LocalRankRepository().computeRank(450),
          LocalRankRepository.bronze4,
        );
        expect(
          const LocalRankRepository().computeRank(499),
          LocalRankRepository.bronze4,
        );
      });

      test('returns Bronze 3 if elo is between 500 and 599.', () {
        expect(
          const LocalRankRepository().computeRank(500),
          LocalRankRepository.bronze3,
        );
        expect(
          const LocalRankRepository().computeRank(550),
          LocalRankRepository.bronze3,
        );
        expect(
          const LocalRankRepository().computeRank(599),
          LocalRankRepository.bronze3,
        );
      });

      test('returns Bronze 2 if elo is between 600 and 699.', () {
        expect(
          const LocalRankRepository().computeRank(600),
          LocalRankRepository.bronze2,
        );
        expect(
          const LocalRankRepository().computeRank(650),
          LocalRankRepository.bronze2,
        );
        expect(
          const LocalRankRepository().computeRank(699),
          LocalRankRepository.bronze2,
        );
      });

      test('returns Bronze 1 if elo is between 700 and 799.', () {
        expect(
          const LocalRankRepository().computeRank(700),
          LocalRankRepository.bronze1,
        );
        expect(
          const LocalRankRepository().computeRank(750),
          LocalRankRepository.bronze1,
        );
        expect(
          const LocalRankRepository().computeRank(799),
          LocalRankRepository.bronze1,
        );
      });
    });

    group('Silver', () {
      test('returns Silver 4 if elo is between 800 and 899.', () {
        expect(
          const LocalRankRepository().computeRank(800),
          LocalRankRepository.silver4,
        );
        expect(
          const LocalRankRepository().computeRank(850),
          LocalRankRepository.silver4,
        );
        expect(
          const LocalRankRepository().computeRank(899),
          LocalRankRepository.silver4,
        );
      });

      test('returns Silver 3 if elo is between 900 and 999.', () {
        expect(
          const LocalRankRepository().computeRank(900),
          LocalRankRepository.silver3,
        );
        expect(
          const LocalRankRepository().computeRank(950),
          LocalRankRepository.silver3,
        );
        expect(
          const LocalRankRepository().computeRank(999),
          LocalRankRepository.silver3,
        );
      });

      test('returns Silver 2 if elo is between 1000 and 1099.', () {
        expect(
          const LocalRankRepository().computeRank(1000),
          LocalRankRepository.silver2,
        );
        expect(
          const LocalRankRepository().computeRank(1050),
          LocalRankRepository.silver2,
        );
        expect(
          const LocalRankRepository().computeRank(1099),
          LocalRankRepository.silver2,
        );
      });

      test('returns Silver 1 if elo is between 1100 and 1199.', () {
        expect(
          const LocalRankRepository().computeRank(1100),
          LocalRankRepository.silver1,
        );
        expect(
          const LocalRankRepository().computeRank(1150),
          LocalRankRepository.silver1,
        );
        expect(
          const LocalRankRepository().computeRank(1199),
          LocalRankRepository.silver1,
        );
      });
    });

    group('Gold', () {
      test('returns Gold 4 if elo is between 1200 and 1299.', () {
        expect(
          const LocalRankRepository().computeRank(1200),
          LocalRankRepository.gold4,
        );
        expect(
          const LocalRankRepository().computeRank(1250),
          LocalRankRepository.gold4,
        );
        expect(
          const LocalRankRepository().computeRank(1299),
          LocalRankRepository.gold4,
        );
      });

      test('returns Gold 3 if elo is between 1300 and 1399.', () {
        expect(
          const LocalRankRepository().computeRank(1300),
          LocalRankRepository.gold3,
        );
        expect(
          const LocalRankRepository().computeRank(1350),
          LocalRankRepository.gold3,
        );
        expect(
          const LocalRankRepository().computeRank(1399),
          LocalRankRepository.gold3,
        );
      });

      test('returns Gold 2 if elo is between 1400 and 1499.', () {
        expect(
          const LocalRankRepository().computeRank(1400),
          LocalRankRepository.gold2,
        );
        expect(
          const LocalRankRepository().computeRank(1450),
          LocalRankRepository.gold2,
        );
        expect(
          const LocalRankRepository().computeRank(1499),
          LocalRankRepository.gold2,
        );
      });

      test('returns Gold 1 if elo is between 1500 and 1599.', () {
        expect(
          const LocalRankRepository().computeRank(1500),
          LocalRankRepository.gold1,
        );
        expect(
          const LocalRankRepository().computeRank(1550),
          LocalRankRepository.gold1,
        );
        expect(
          const LocalRankRepository().computeRank(1599),
          LocalRankRepository.gold1,
        );
      });
    });

    group('Platinum', () {
      test('returns Platinum 4 if elo is between 1600 and 1699.', () {
        expect(
          const LocalRankRepository().computeRank(1600),
          LocalRankRepository.platinum4,
        );
        expect(
          const LocalRankRepository().computeRank(1650),
          LocalRankRepository.platinum4,
        );
        expect(
          const LocalRankRepository().computeRank(1699),
          LocalRankRepository.platinum4,
        );
      });

      test('returns Platinum 3 if elo is between 1700 and 1799.', () {
        expect(
          const LocalRankRepository().computeRank(1700),
          LocalRankRepository.platinum3,
        );
        expect(
          const LocalRankRepository().computeRank(1750),
          LocalRankRepository.platinum3,
        );
        expect(
          const LocalRankRepository().computeRank(1799),
          LocalRankRepository.platinum3,
        );
      });

      test('returns Platinum 2 if elo is between 1800 and 1899.', () {
        expect(
          const LocalRankRepository().computeRank(1800),
          LocalRankRepository.platinum2,
        );
        expect(
          const LocalRankRepository().computeRank(1850),
          LocalRankRepository.platinum2,
        );
        expect(
          const LocalRankRepository().computeRank(1899),
          LocalRankRepository.platinum2,
        );
      });

      test('returns Platinum 1 if elo is between 1900 and 1999.', () {
        expect(
          const LocalRankRepository().computeRank(1900),
          LocalRankRepository.platinum1,
        );
        expect(
          const LocalRankRepository().computeRank(1950),
          LocalRankRepository.platinum1,
        );
        expect(
          const LocalRankRepository().computeRank(1999),
          LocalRankRepository.platinum1,
        );
      });
    });

    group('Emerald', () {
      test('returns Emerald 4 if elo is between 2000 and 2099.', () {
        expect(
          const LocalRankRepository().computeRank(2000),
          LocalRankRepository.emerald4,
        );
        expect(
          const LocalRankRepository().computeRank(2050),
          LocalRankRepository.emerald4,
        );
        expect(
          const LocalRankRepository().computeRank(2099),
          LocalRankRepository.emerald4,
        );
      });

      test('returns Emerald 3 if elo is between 2100 and 2199.', () {
        expect(
          const LocalRankRepository().computeRank(2100),
          LocalRankRepository.emerald3,
        );
        expect(
          const LocalRankRepository().computeRank(2150),
          LocalRankRepository.emerald3,
        );
        expect(
          const LocalRankRepository().computeRank(2199),
          LocalRankRepository.emerald3,
        );
      });

      test('returns Emerald 2 if elo is between 2200 and 2299.', () {
        expect(
          const LocalRankRepository().computeRank(2200),
          LocalRankRepository.emerald2,
        );
        expect(
          const LocalRankRepository().computeRank(2250),
          LocalRankRepository.emerald2,
        );
        expect(
          const LocalRankRepository().computeRank(2299),
          LocalRankRepository.emerald2,
        );
      });

      test('returns Emerald 1 if elo is between 2300 and 2399.', () {
        expect(
          const LocalRankRepository().computeRank(2300),
          LocalRankRepository.emerald1,
        );
        expect(
          const LocalRankRepository().computeRank(2350),
          LocalRankRepository.emerald1,
        );
        expect(
          const LocalRankRepository().computeRank(2399),
          LocalRankRepository.emerald1,
        );
      });
    });

    group('Diamond', () {
      test('returns Diamond 4 if elo is between 2400 and 2499.', () {
        expect(
          const LocalRankRepository().computeRank(2400),
          LocalRankRepository.diamond4,
        );
        expect(
          const LocalRankRepository().computeRank(2450),
          LocalRankRepository.diamond4,
        );
        expect(
          const LocalRankRepository().computeRank(2499),
          LocalRankRepository.diamond4,
        );
      });

      test('returns Diamond 3 if elo is between 2500 and 2599.', () {
        expect(
          const LocalRankRepository().computeRank(2500),
          LocalRankRepository.diamond3,
        );
        expect(
          const LocalRankRepository().computeRank(2550),
          LocalRankRepository.diamond3,
        );
        expect(
          const LocalRankRepository().computeRank(2599),
          LocalRankRepository.diamond3,
        );
      });

      test('returns Diamond 2 if elo is between 2600 and 2699.', () {
        expect(
          const LocalRankRepository().computeRank(2600),
          LocalRankRepository.diamond2,
        );
        expect(
          const LocalRankRepository().computeRank(2650),
          LocalRankRepository.diamond2,
        );
        expect(
          const LocalRankRepository().computeRank(2699),
          LocalRankRepository.diamond2,
        );
      });

      test('returns Diamond 1 if elo is between 2700 and 2799.', () {
        expect(
          const LocalRankRepository().computeRank(2700),
          LocalRankRepository.diamond1,
        );
        expect(
          const LocalRankRepository().computeRank(2750),
          LocalRankRepository.diamond1,
        );
        expect(
          const LocalRankRepository().computeRank(2799),
          LocalRankRepository.diamond1,
        );
      });
    });

    group('Master', () {
      test('returns Master 4 if elo is between 2800 and 2899.', () {
        expect(
          const LocalRankRepository().computeRank(2800),
          LocalRankRepository.master4,
        );
        expect(
          const LocalRankRepository().computeRank(2850),
          LocalRankRepository.master4,
        );
        expect(
          const LocalRankRepository().computeRank(2899),
          LocalRankRepository.master4,
        );
      });

      test('returns Master 3 if elo is between 2900 and 2999.', () {
        expect(
          const LocalRankRepository().computeRank(2900),
          LocalRankRepository.master3,
        );
        expect(
          const LocalRankRepository().computeRank(2950),
          LocalRankRepository.master3,
        );
        expect(
          const LocalRankRepository().computeRank(2999),
          LocalRankRepository.master3,
        );
      });

      test('returns Master 2 if elo is between 3000 and 3099.', () {
        expect(
          const LocalRankRepository().computeRank(3000),
          LocalRankRepository.master2,
        );
        expect(
          const LocalRankRepository().computeRank(3050),
          LocalRankRepository.master2,
        );
        expect(
          const LocalRankRepository().computeRank(3099),
          LocalRankRepository.master2,
        );
      });

      test('returns Master 1 if elo is between 3100 and 3199.', () {
        expect(
          const LocalRankRepository().computeRank(3100),
          LocalRankRepository.master1,
        );
        expect(
          const LocalRankRepository().computeRank(3150),
          LocalRankRepository.master1,
        );
        expect(
          const LocalRankRepository().computeRank(3199),
          LocalRankRepository.master1,
        );
      });
    });

    group('Grandmaster', () {
      test('returns Grandmaster 4 if elo is between 3200 and 3299.', () {
        expect(
          const LocalRankRepository().computeRank(3200),
          LocalRankRepository.grandmaster4,
        );
        expect(
          const LocalRankRepository().computeRank(3250),
          LocalRankRepository.grandmaster4,
        );
        expect(
          const LocalRankRepository().computeRank(3299),
          LocalRankRepository.grandmaster4,
        );
      });

      test('returns Grandmaster 3 if elo is between 3300 and 3399.', () {
        expect(
          const LocalRankRepository().computeRank(3300),
          LocalRankRepository.grandmaster3,
        );
        expect(
          const LocalRankRepository().computeRank(3350),
          LocalRankRepository.grandmaster3,
        );
        expect(
          const LocalRankRepository().computeRank(3399),
          LocalRankRepository.grandmaster3,
        );
      });

      test('returns Grandmaster 2 if elo is between 3400 and 3499.', () {
        expect(
          const LocalRankRepository().computeRank(3400),
          LocalRankRepository.grandmaster2,
        );
        expect(
          const LocalRankRepository().computeRank(3450),
          LocalRankRepository.grandmaster2,
        );
        expect(
          const LocalRankRepository().computeRank(3499),
          LocalRankRepository.grandmaster2,
        );
      });

      test('returns Grandmaster 1 if elo is between 3500 and 3599.', () {
        expect(
          const LocalRankRepository().computeRank(3500),
          LocalRankRepository.grandmaster1,
        );
        expect(
          const LocalRankRepository().computeRank(3550),
          LocalRankRepository.grandmaster1,
        );
        expect(
          const LocalRankRepository().computeRank(3599),
          LocalRankRepository.grandmaster1,
        );
      });
    });

    group('Challenger', () {
      test('returns Challenger 4 if elo is between 3600 and 3699.', () {
        expect(
          const LocalRankRepository().computeRank(3600),
          LocalRankRepository.challenger4,
        );
        expect(
          const LocalRankRepository().computeRank(3650),
          LocalRankRepository.challenger4,
        );
        expect(
          const LocalRankRepository().computeRank(3699),
          LocalRankRepository.challenger4,
        );
      });

      test('returns Challenger 3 if elo is between 3700 and 3799.', () {
        expect(
          const LocalRankRepository().computeRank(3700),
          LocalRankRepository.challenger3,
        );
        expect(
          const LocalRankRepository().computeRank(3750),
          LocalRankRepository.challenger3,
        );
        expect(
          const LocalRankRepository().computeRank(3799),
          LocalRankRepository.challenger3,
        );
      });

      test('returns Challenger 2 if elo is between 3800 and 3899.', () {
        expect(
          const LocalRankRepository().computeRank(3800),
          LocalRankRepository.challenger2,
        );
        expect(
          const LocalRankRepository().computeRank(3850),
          LocalRankRepository.challenger2,
        );
        expect(
          const LocalRankRepository().computeRank(3899),
          LocalRankRepository.challenger2,
        );
      });

      test('returns Challenger 1 if elo is between 3900 and 3999.', () {
        expect(
          const LocalRankRepository().computeRank(3900),
          LocalRankRepository.challenger1,
        );
        expect(
          const LocalRankRepository().computeRank(3950),
          LocalRankRepository.challenger1,
        );
        expect(
          const LocalRankRepository().computeRank(3999),
          LocalRankRepository.challenger1,
        );
        expect(
          const LocalRankRepository().computeRank(4000),
          LocalRankRepository.challenger1,
        );
        expect(
          const LocalRankRepository().computeRank(4500),
          LocalRankRepository.challenger1,
        );
      });
    });
  });
}
