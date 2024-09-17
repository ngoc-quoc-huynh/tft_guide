import 'package:flutter/widgets.dart';

typedef CustomBlocWidgetBuilder<S> = Widget Function(
  BuildContext context,
  S state,
  Widget? child,
);
