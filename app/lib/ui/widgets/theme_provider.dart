import 'package:flutter/material.dart';

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    required this.data,
    required this.child,
    super.key,
  });

  final ThemeData? data;
  final Widget child;

  @override
  Widget build(BuildContext context) => switch (data) {
        null => child,
        final ThemeData data => Theme(
            data: data,
            child: child,
          ),
      };
}
