import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
import 'package:tft_guide/ui/pages/item/component.dart';
import 'package:tft_guide/ui/widgets/background.dart';
import 'package:tft_guide/ui/widgets/item_builder.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({required this.id, super.key});

  final int id;

  static const routeName = 'item';

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).primaryTextTheme.headlineSmall;
    return ItemBuilder(
      id: id,
      builder: (context, item) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(item.name),
        ),
        body: Background(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Image.asset(
                  item.asset.path,
                  fit: BoxFit.contain,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  _messages.description,
                  style: headerStyle,
                ),
                const SizedBox(height: 10),
                Text(item.description),
                const SizedBox(height: 20),
                Text(
                  _messages.hint,
                  style: headerStyle,
                ),
                const SizedBox(height: 10),
                Text(item.hint),
                if (item is FullItem) ...[
                  const SizedBox(height: 20),
                  Text(
                    _messages.components,
                    style: headerStyle,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ItemComponent(item: item.component1),
                      const Icon(
                        Icons.add,
                        size: 40,
                      ),
                      ItemComponent(item: item.component2),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  ItemPagesMessages get _messages => Injector.instance.messages.pages.item;
}
