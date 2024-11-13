import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/asset.dart';
import 'package:tft_guide/ui/utils/mixins/animation.dart';

class RankedRankAsset extends StatefulWidget {
  const RankedRankAsset({
    required this.asset,
    super.key,
  });

  final Asset asset;

  @override
  State<RankedRankAsset> createState() => _RankedRankAssetState();
}

class _RankedRankAssetState extends State<RankedRankAsset>
    with AnimationMixin, SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Asset _oldAsset;
  Timer? _timer;
  bool _showNewAsset = false;

  @override
  void initState() {
    super.initState();
    _oldAsset = widget.asset;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0.7)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1).chain(
          CurveTween(curve: Curves.elasticOut),
        ),
        weight: 50,
      ),
    ]).animate(_controller);
    _controller.addStatusListener(_handleAnimationStatus);
  }

  @override
  void didUpdateWidget(covariant RankedRankAsset oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset != widget.asset) {
      _playAnimation(oldWidget.asset);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Image.asset(
          _asset(),
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Asset get _asset =>
      _showNewAsset || _controller.value >= 0.5 ? widget.asset : _oldAsset;

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _showNewAsset = true;
    }
  }

  void _playAnimation(Asset oldAsset) {
    _oldAsset = oldAsset;
    _showNewAsset = false;
    _controller.reset();

    _timer?.cancel();
    _timer = Timer(
      computeRankAnimationDuration(context.read<EloGainCubit>().state),
      () => _controller.forward(),
    );
  }
}
