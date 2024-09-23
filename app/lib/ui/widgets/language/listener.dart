import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';

class LanguageListener extends StatelessWidget {
  const LanguageListener({
    required this.onLanguageChanged,
    required this.child,
    super.key,
  });

  final ValueChanged<LanguageCode> onLanguageChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCodeValueCubit, LanguageCode>(
      listener: (context, languageCode) => onLanguageChanged.call(languageCode),
      child: child,
    );
  }
}
