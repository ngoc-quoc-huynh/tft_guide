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
          _Image(itemId1),
          const Icon(Icons.add),
          _Image(itemId2),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(this.id);

  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Ink.image(
        image: AssetImage(Assets.bfSword.path),
        height: FullItemDetailCombineBy.imageSize,
        width: FullItemDetailCombineBy.imageSize,
        fit: BoxFit.contain,
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
