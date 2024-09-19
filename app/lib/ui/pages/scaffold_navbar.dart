import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/patch_notes_unread_counter/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/router/routes.dart';
import 'package:tft_guide/ui/widgets/badge.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/language/builder.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatchNotesUnreadCounterBloc>(
      create: (_) => PatchNotesUnreadCounterBloc()
        ..add(const PatchNotesUnreadCounterInitializeEvent()),
      child: LanguageBuilder(
        builder: (context) => Scaffold(
          appBar: CustomAppBar(
            actions: [
              IconButton(
                onPressed: () => unawaited(
                  context.pushNamed(Routes.settingsPage()),
                ),
                icon: const Icon(Icons.settings),
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
          body: navigationShell,
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
  }

  static TranslationsPagesEn get _translations =>
      Injector.instance.translations.pages;
}
