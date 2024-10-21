import 'package:flutter/material.dart';

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    required this.data,
    required this.builder,
    super.key,
  });

  final ThemeData? data;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => switch (data) {
        null => builder.call(context),
        final ThemeData data => Theme(
            data: data,
            child: Builder(
              builder: builder,
            ),
          ),
      };
}
