import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/theme_mode/cubit.dart';

class WidgetObserver extends StatefulWidget {
  const WidgetObserver({
    required this.child,
    this.onBrightnessChanged,
    super.key,
  });

  final Widget child;
  final ValueChanged<Brightness>? onBrightnessChanged;

  @override
  State<WidgetObserver> createState() => _WidgetObserverState();
}

class _WidgetObserverState extends State<WidgetObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (context.read<ThemeModeCubit>().state == ThemeMode.system) {
      widget.onBrightnessChanged?.call(
        View.of(context).platformDispatcher.platformBrightness,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
