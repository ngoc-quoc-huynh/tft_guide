part of 'combine_by.dart';

final class _Combine extends FullItemDetailCombineBy {
  const _Combine({
    required this.itemId1,
    required this.itemId2,
    super.key,
  });

  final String itemId1;
  final String itemId2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FullItemDetailCombineBy.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Image(
            id: itemId1,
            tooltip: _translations.item1,
          ),
          const Icon(Icons.add),
          _Image(
            id: itemId2,
            tooltip: _translations.item2,
          ),
        ],
      ),
    );
  }

  static TranslationsPagesItemDetailEn get _translations =>
      Injector.instance.translations.pages.itemDetail;
}

class _Image extends StatelessWidget {
  const _Image({
    required this.id,
    required this.tooltip,
  });

  final String id;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _onTap(context),
        child: FileStorageImage(
          id: id,
          height: FullItemDetailCombineBy.imageSize,
          width: FullItemDetailCombineBy.imageSize,
        ),
      ),
    );
  }

  void _onTap(BuildContext context) => unawaited(
        context.pushNamed(
          Routes.baseItemsPage(),
          pathParameters: {'id': id},
        ),
      );
}
