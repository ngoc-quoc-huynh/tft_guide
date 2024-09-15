import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownText extends StatelessWidget {
  const MarkdownText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet(
        strong: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        p: textTheme.bodyLarge,
        h1: textTheme.headlineSmall,
        h2: textTheme.titleLarge,
      ),
    );
  }
}
