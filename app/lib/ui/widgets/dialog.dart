import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.content,
    this.action,
    super.key,
  });

  final Widget title;
  final Widget content;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _shape,
      titlePadding: _titlePadding,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: title,
          ),
          const CloseButton(),
        ],
      ),
      contentPadding: _contentPadding,
      content: content,
      actionsPadding: _actionsPadding,
      actionsAlignment: MainAxisAlignment.center,
      actions: [if (action case final action?) action],
    );
  }

  static const _titlePadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    left: Sizes.horizontalPadding,
  );
  static const _contentPadding = EdgeInsets.only(
    top: Sizes.verticalPadding / 2,
    bottom: Sizes.verticalPadding / 2,
    right: Sizes.horizontalPadding,
    left: Sizes.horizontalPadding,
  );
  static const _actionsPadding = EdgeInsets.only(
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
    bottom: Sizes.verticalPadding,
  );
  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
}
