extension BoolExtension on bool {
  static bool parseInt(int n) => switch (n) {
        0 => false,
        1 => true,
        _ => throw const FormatException('Invalid boolean'),
      };
}
