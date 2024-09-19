import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    required this.text,
    this.textAlign,
    super.key,
  });

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: textAlign,
    );
  }
}
