import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/markdown_text.dart';

Future<void> main() => goldenTest(
      'renders correctly',
      fileName: 'markdown_text',
      builder: () => const MarkdownText(
        text: '''
# Heading 1
## Heading 2
**Bold text**
Regular text.
''',
      ),
    );
