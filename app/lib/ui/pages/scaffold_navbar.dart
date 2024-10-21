import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/app_update_info/cubit.dart';
import 'package:tft_guide/domain/blocs/patch_notes_unread_counter/bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/router/routes.dart';
import 'package:tft_guide/ui/widgets/badge.dart';
import 'package:tft_guide/ui/widgets/bloc/builder.dart';
import 'package:tft_guide/ui/widgets/bloc/selector.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/language/builder.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PatchNotesUnreadCounterBloc>(
          create: (_) => PatchNotesUnreadCounterBloc()
            ..add(const PatchNotesUnreadCounterInitializeEvent()),
        ),
        BlocProvider<NavigationBarValueCubit>(
          create: (_) => NavigationBarValueCubit(NavigationBarState.ranked),
        ),
      ],
      child: LanguageBuilder(
        builder: (context) => BlocSelectorWithChild<NavigationBarValueCubit,
            NavigationBarState, bool>(
          selector: (state) =>
              state == NavigationBarState.itemMetas ||
              state == NavigationBarState.patchNotes,
          builder: (context, isScrollable, child) => CustomScaffold(
            appBar: CustomAppBar.tft(
              forceMaterialTransparency: !isScrollable,
              systemNavigationBarColor:
                  Theme.of(context).colorScheme.surfaceContainer,
              actions: [
                IconButton(
                  tooltip: _translations.settings.title,
                  onPressed: () => unawaited(
                    context.pushNamed(Routes.settingsPage()),
                  ),
                  icon:
                      BlocBuilderWithChild<AppUpdateInfoCubit, AppUpdateInfo?>(
                    builder: (context, state, child) => BadgeCounter(
                      count: switch (state) {
                        null => 0,
                        AppUpdateInfo() => 1,
                      },
                      child: child,
                    ),
                    child: const Icon(Icons.settings),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.emoji_events),
                  label: _translations.ranked.title,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.format_list_bulleted),
                  label: _translations.itemMetas.title,
                ),
                NavigationDestination(
                  icon: BlocBuilder<PatchNotesUnreadCounterBloc,
                      PatchNotesUnreadCounterState>(
                    builder: (context, state) => BadgeCounter(
                      count: switch (state) {
                        PatchNotesUnreadCounterLoadInProgress() => 0,
                        PatchNotesUnreadCounterLoadOnSuccess(
                          :final unreadCount
                        ) =>
                          unreadCount,
                      },
                      child: const Icon(Icons.newspaper),
                    ),
                  ),
                  label: _translations.patchNotes.title,
                ),
              ],
            ),
            body: child!,
          ),
          child: navigationShell,
        ),
      ),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    if (index == 2) {
      context
          .read<PatchNotesUnreadCounterBloc>()
          .add(const PatchNotesUnreadCounterReadEvent());
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    context
        .read<NavigationBarValueCubit>()
        .update(NavigationBarState.values[index]);
  }

  static TranslationsPagesEn get _translations =>
      Injector.instance.translations.pages;
}
