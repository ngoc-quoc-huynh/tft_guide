import 'package:tft_guide/domain/blocs/item_detail/bloc.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/item_detail/full_item/combine_by/combine_by.dart';
import 'package:tft_guide/ui/pages/item_detail/page.dart';
import 'package:tft_guide/ui/widgets/item_detail/card.dart';
import 'package:tft_guide/ui/widgets/item_detail/sliver_wrapper.dart';
import 'package:tft_guide/ui/widgets/item_detail/title.dart';

final class FullItemDetailPage
    extends ItemDetailPage<FullItemDetailBloc, FullItemDetail> {
  FullItemDetailPage({
    required super.id,
    super.key,
  }) : super(
          createBloc: (_) => FullItemDetailBloc(),
          trailing: (item) => SliverWrapperItemDetail(
            child: ItemDetailCard(
              title: ItemDetailCardTitle.text(
                text: Injector.instance.translations.pages.itemDetail.combine,
              ),
              child: FullItemDetailCombineBy.combine(
                itemId1: item.itemId1,
                itemId2: item.itemId2,
              ),
            ),
          ),
        );
}
