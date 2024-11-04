enum Tier {
  iron('Iron'),
  bronze('Bronze'),
  silver('Silver'),
  gold('Gold'),
  platinum('Platinum'),
  emerald('Emerald'),
  diamond('Diamond'),
  master('Master'),
  grandmaster('Grandmaster'),
  challenger('Challenger');

  const Tier(this.name);

  final String name;
}
