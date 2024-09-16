import 'package:flutter/material.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';
import 'package:tft_guide/injector.dart';

sealed class SettingsCheckIcon extends StatelessWidget {
  const SettingsCheckIcon({
    super.key,
  });

  const factory SettingsCheckIcon.initial({
    Key? key,
  }) = _Initial;

  const factory SettingsCheckIcon.loading({
    Key? key,
  }) = _Loading;

  const factory SettingsCheckIcon.invalid({
    required String message,
    Key? key,
  }) = _Invalid;

  const factory SettingsCheckIcon.valid({
    required String message,
    Key? key,
  }) = _Valid;

  const factory SettingsCheckIcon.error({
    Key? key,
  }) = _Error;
}

final class _Initial extends SettingsCheckIcon {
  const _Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.play_arrow_outlined);
  }
}

final class _Loading extends SettingsCheckIcon {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

final class _Invalid extends SettingsCheckIcon {
  const _Invalid({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return _Icon(
      message: message,
      icon: Icons.close,
      color: Theme.of(context).colorScheme.error,
    );
  }
}

final class _Valid extends SettingsCheckIcon {
  const _Valid({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return _Icon(
      message: message,
      icon: Icons.check,
      color: Theme.of(context).customColors.success,
    );
  }
}

final class _Error extends SettingsCheckIcon {
  const _Error({super.key});

  @override
  Widget build(BuildContext context) {
    return _Icon(
      message: Injector.instance.translations.pages.settings.check.networkError,
      icon: Icons.warning_amber,
      color: Theme.of(context).customColors.warning,
    );
  }
}

final class _Icon extends StatelessWidget {
  const _Icon({
    required this.message,
    required this.icon,
    required this.color,
  });

  final String message;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
