import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';

class CustomAlertDialog<T> extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
    super.key,
  });

  final String title;
  final Widget content;
  final List<AlertDialogAction<T>> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _shape,
      titlePadding: _titlePadding,
      title: Text(title),
      contentPadding: _contentPadding,
      content: content,
      actionsPadding: _actionsPadding,
      actions: actions,
    );
  }

  static const _titlePadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
  );
  static const _contentPadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    bottom: Sizes.verticalPadding / 2,
  );
  static const _actionsPadding = EdgeInsets.only(
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
    bottom: Sizes.verticalPadding / 2,
  );
  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
}
