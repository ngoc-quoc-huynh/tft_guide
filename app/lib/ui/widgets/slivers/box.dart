import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverSizedBox extends SingleChildRenderObjectWidget {
  const SliverSizedBox({
    this.width,
    this.height,
    super.key,
  });

  final double? width;
  final double? height;

  @override
  RenderSliverSizedBox createRenderObject(BuildContext context) =>
      RenderSliverSizedBox(
        width: width,
        height: height,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverSizedBox renderObject,
  ) =>
      renderObject
        ..width = width
        ..height = height;
}

class RenderSliverSizedBox extends RenderSliver {
  RenderSliverSizedBox({
    double? width,
    double? height,
  })  : _width = width,
        _height = height;

  double? _width;
  double? _height;

  double? get width => _width;

  double? get height => _height;

  set width(double? value) {
    if (_width != value) {
      _width = value;
      markNeedsLayout();
    }
  }

  set height(double? value) {
    if (_height != value) {
      _height = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final paintExtent = height ?? constraints.remainingPaintExtent;
    final crossAxisExtent = width ?? constraints.crossAxisExtent;

    geometry = SliverGeometry(
      scrollExtent: paintExtent,
      paintExtent: paintExtent.clamp(0, constraints.remainingPaintExtent),
      maxPaintExtent: paintExtent,
      crossAxisExtent: crossAxisExtent,
    );
  }
}
