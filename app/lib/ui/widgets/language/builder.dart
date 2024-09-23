import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';

class LanguageBuilder extends StatelessWidget {
  const LanguageBuilder({
    required this.builder,
    super.key,
  });

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCodeValueCubit, LanguageCode>(
      builder: (context, _) => builder.call(context),
    );
  }
}
