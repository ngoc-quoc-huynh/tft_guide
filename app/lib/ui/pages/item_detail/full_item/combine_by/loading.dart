part of 'combine_by.dart';

final class _Loading extends FullItemDetailCombineBy {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: FullItemDetailCombineBy.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _LoadingItem(),
          Bone.icon(),
          _LoadingItem(),
        ],
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return const Bone.square(
      size: FullItemDetailCombineBy.imageSize,
    );
  }
}
