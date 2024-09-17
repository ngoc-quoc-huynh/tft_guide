import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/ui/widgets/bloc/types.dart';

final class BlocBuilderWithChild<B extends BlocBase<S>, S>
    extends StatelessWidget {
  const BlocBuilderWithChild({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  final CustomBlocWidgetBuilder<S> builder;
  final BlocBuilderCondition<S>? buildWhen;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      buildWhen: buildWhen,
      builder: (context, state) => builder(
        context,
        state,
        child,
      ),
    );
  }
}
