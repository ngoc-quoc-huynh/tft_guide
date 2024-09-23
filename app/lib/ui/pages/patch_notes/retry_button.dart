import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/patch_notes/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/slivers/box.dart';

class PatchNotesRetryButton extends StatelessWidget {
  const PatchNotesRetryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: Sizes.horizontalPadding,
        right: Sizes.horizontalPadding,
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          const SliverSizedBox(height: 10),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 10,
              left: Sizes.horizontalPadding,
              right: Sizes.horizontalPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                _translations.errors.loadMore,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          ),
          const SliverSizedBox(height: 10),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () => context
                  .read<PatchNotesBloc>()
                  .add(const PatchNotesLoadMoreEvent()),
              child: Text(_translations.retry),
            ),
          ),
        ],
      ),
    );
  }

  TranslationsPagesPatchNotesEn get _translations =>
      Injector.instance.translations.pages.patchNotes;
}
