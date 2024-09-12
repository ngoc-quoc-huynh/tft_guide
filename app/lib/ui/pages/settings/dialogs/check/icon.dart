import 'package:flutter/material.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';

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

  const factory SettingsCheckIcon.error({
    Key? key,
  }) = _Error;

  const factory SettingsCheckIcon.success({
    Key? key,
  }) = _Success;
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

final class _Error extends SettingsCheckIcon {
  const _Error({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.close,
      color: Theme.of(context).colorScheme.error,
    );
  }
}

final class _Success extends SettingsCheckIcon {
  const _Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check,
      color: Theme.of(context).customColors.success,
    );
  }
}
