import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/patch_note.dart';
import 'package:tft_guide/domain/utils/extensions/date_time.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/markdown_text.dart';

class PatchNotesCard extends StatelessWidget {
  const PatchNotesCard({
    required this.patchNote,
    super.key,
  });

  final PatchNote patchNote;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: Sizes.cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patchNote.createdAt.format(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 5),
            MarkdownText(text: patchNote.text),
          ],
        ),
      ),
    );
  }
}
