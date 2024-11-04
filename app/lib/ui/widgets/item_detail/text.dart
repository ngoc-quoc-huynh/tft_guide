import 'package:flutter/material.dart';

class ItemDetailCardText extends StatelessWidget {
  const ItemDetailCardText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
