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

  TranslationsPagesItemDetailDe get _translations =>
      Injector.instance.translations.pages.item_detail;
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
        child: Ink.image(
          image: FileImage(
            Injector.instance.fileStorageAPI.loadFile(id),
          ),
          height: FullItemDetailCombineBy.imageSize,
          width: FullItemDetailCombineBy.imageSize,
          fit: BoxFit.contain,
          // TODO: Add error widget
        ),
      ),
    );
  }

  void _onTap(BuildContext context) => unawaited(
        context.pushNamed(
          BaseItemDetailPage.routeName,
          pathParameters: {'id': id},
        ),
      );
}
