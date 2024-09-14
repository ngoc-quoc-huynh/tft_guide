import 'package:flutter/material.dart';

class BadgeCounter extends StatelessWidget {
  const BadgeCounter({
    required this.count,
    required this.child,
    super.key,
  });

  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(
        switch (count) {
          > 9 => '9+',
          _ => '$count',
        },
      ),
      isLabelVisible: count != 0,
      child: child,
    );
  }
}
