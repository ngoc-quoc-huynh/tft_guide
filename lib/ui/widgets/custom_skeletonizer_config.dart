import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeletonizerConfig extends StatelessWidget {
  const CustomSkeletonizerConfig({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effect: ShimmerEffect(
          highlightColor: Theme.of(context).colorScheme.surface,
          baseColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      child: child,
    );
  }
}
