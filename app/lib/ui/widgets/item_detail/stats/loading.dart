part of 'stats.dart';

class _Loading extends ItemDetailStats {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ItemDetailStats.padding,
      child: SizedBox(
        height: 30,
        child: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: ItemDetailStats.crossAxisCount,
          mainAxisSpacing: ItemDetailStats.mainAxisSpacing,
          itemBuilder: (_, __) => const _LoadingItem(),
          itemCount: 2,
        ),
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Bone.icon(),
        const SizedBox(width: 5),
        Text(
          BoneMock.chars(3),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
