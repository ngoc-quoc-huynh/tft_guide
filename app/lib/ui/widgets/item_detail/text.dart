import 'package:flutter/material.dart';

class ItemDetailCardBodyText extends StatelessWidget {
  const ItemDetailCardBodyText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
