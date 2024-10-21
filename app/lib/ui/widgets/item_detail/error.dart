import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/error_text.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';

class ItemDetailErrorPage<T extends ItemDetail> extends StatelessWidget {
  const ItemDetailErrorPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Sizes.horizontalPadding),
        child: Center(
          child: ErrorText(
            text: _message(id),
          ),
        ),
      ),
    );
  }

  String _message(String id) {
    if (T == BaseItemDetail) {
      return _translations.baseItem(id: id);
    } else {
      return _translations.fullItem(id: id);
    }
  }

  TranslationsPagesItemDetailErrorsEn get _translations =>
      Injector.instance.translations.pages.itemDetail.errors;
}
