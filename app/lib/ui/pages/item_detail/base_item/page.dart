import 'package:tft_guide/domain/blocs/item_detail/bloc.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/ui/pages/item_detail/page.dart';

final class BaseItemDetailPage
    extends ItemDetailPage<BaseItemDetailBloc, BaseItemDetail> {
  BaseItemDetailPage({
    required super.id,
    super.key,
  }) : super(createBloc: (_) => BaseItemDetailBloc());
}
