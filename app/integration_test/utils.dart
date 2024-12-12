import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/ui/widgets/image/optimized.dart';

extension CommonFindersExtension on CommonFinders {
  Finder optimizedImage(ImageProvider image) => byWidgetPredicate(
        (e) => e is OptimizedImage && e.image == image,
      );
}
