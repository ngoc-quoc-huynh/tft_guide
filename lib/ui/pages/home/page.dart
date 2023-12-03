import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tft_guide/domain/blocs/bottom_navigation/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
import 'package:tft_guide/static/resources/colors.dart';
import 'package:tft_guide/ui/pages/items/page.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';
import 'package:tft_guide/ui/pages/settings/page.dart';
import 'package:tft_guide/ui/widgets/background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = 'home';

  static const _pages = [
    RankedPage(),
    ItemsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationCubit>(
      create: (_) => BottomNavigationCubit(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(_messages.appName),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) => GNav(
              selectedIndex: state.index,
              gap: 8,
              iconSize: 20,
              color: Colors.grey[600],
              tabBackgroundColor: Colors.grey[900]!,
              activeColor: CustomColors.orange,
              rippleColor: CustomColors.orange,
              hoverColor: CustomColors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              haptic: false,
              onTabChange: (index) => context
                  .read<BottomNavigationCubit>()
                  .switchStateTo(BottomNavigationState.values[index]),
              tabs: [
                GButton(
                  icon: LineIcons.lightbulb,
                  text: _pagesMessages.ranked.title,
                ),
                GButton(
                  icon: LineIcons.list,
                  text: _pagesMessages.items.title,
                ),
                GButton(
                  icon: Icons.settings,
                  text: _pagesMessages.settings.title,
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) => Background(
            child: SafeArea(
              child: LazyIndexedStack(
                index: state.index,
                children: _pages,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Messages get _messages => Injector.instance.messages;

  PagesMessages get _pagesMessages => Injector.instance.messages.pages;
}
