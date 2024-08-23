import 'package:flutter/cupertino.dart';

// TODO: Create a real sliver
class SliverSizedBox extends StatelessWidget {
  const SliverSizedBox({
    this.width,
    this.height,
    super.key,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
