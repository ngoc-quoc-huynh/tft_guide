import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/patch_notes/bloc.dart';
import 'package:tft_guide/domain/models/patch_note.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/patch_notes/card.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/slivers/box.dart';

class PatchNotesBody extends StatefulWidget {
  const PatchNotesBody({
    required this.patchNotes,
    required this.isLastPage,
    super.key,
  });

  final List<PatchNote> patchNotes;
  final bool isLastPage;

  @override
  State<PatchNotesBody> createState() => _PatchNotesBodyState();
}

class _PatchNotesBodyState extends State<PatchNotesBody> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollControllerListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatchNotesBloc, PatchNotesState>(
      listener: (context, state) {
        if (state case PatchNotesChangeLocaleOnSuccess()) {
          _controller.jumpTo(0);
        }
      },
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
              top: Sizes.verticalPadding,
              left: Sizes.horizontalPadding,
              right: Sizes.horizontalPadding,
            ),
            sliver: SliverList.builder(
              itemBuilder: (context, index) => PatchNotesCard(
                patchNote: widget.patchNotes[index],
              ),
              itemCount: widget.patchNotes.length,
            ),
          ),
          if (!widget.isLastPage) ...[
            const SliverSizedBox(height: 10),
            const SliverToBoxAdapter(
              child: LoadingIndicator(),
            ),
          ],
          const SliverSizedBox(height: Sizes.verticalPadding),
        ],
      ),
    );
  }

  void _scrollControllerListener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.position.pixels;

    if (maxScroll - currentScroll <= 100) {
      context.read<PatchNotesBloc>().add(const PatchNotesLoadMoreEvent());
    }
  }
}
