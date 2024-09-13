import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.content,
    required this.action,
    super.key,
  });

  final String title;
  final Widget content;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _shape,
      titlePadding: _titlePadding,
      title: Row(
        children: [
          Text(title),
          const Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: CloseButton(),
            ),
          ),
        ],
      ),
      contentPadding: _contentPadding,
      content: content,
      actionsPadding: _actionsPadding,
      actionsAlignment: MainAxisAlignment.center,
      actions: [action],
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
    bottom: Sizes.verticalPadding / 2,
  );
  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
}
