import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/ui/widgets/bloc/types.dart';

final class BlocSelectorWithChild<B extends BlocBase<S>, S, T>
    extends StatelessWidget {
  const BlocSelectorWithChild({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  final BlocWidgetSelector<S, T> selector;
  final CustomBlocWidgetBuilder<T> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, T>(
      selector: selector,
      builder: (context, value) => builder(
        context,
        value,
        child,
      ),
    );
  }
}
