import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/elo/cubit.dart';
import 'package:tft_guide/domain/blocs/rank/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
import 'package:tft_guide/ui/pages/game/page.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

class RankedPage extends StatelessWidget {
  const RankedPage({super.key});

  static const routeName = 'ranked';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<EloCubit>(
        create: (_) => EloCubit(),
        child: Builder(
          builder: (context) => BlocProvider<RankBloc>(
            create: (_) => RankBloc()
              ..add(RankUpdateEvent(context.read<EloCubit>().state)),
            child: BlocListener<EloCubit, int>(
              listener: (context, elo) =>
                  context.read<RankBloc>().add(RankUpdateEvent(elo)),
              child: BlocBuilder<RankBloc, RankState>(
                builder: (context, state) => switch (state) {
                  RankLoadInProgress() => const LoadingIndicator(),
                  RankLoadOnSuccess() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          state.rank.asset.path,
                          height: 200,
                          width: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _messages.lp(state.lp),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${state.rank.name} ${switch (state.rank.number) {
                            1 => _messages.divisions.one,
                            2 => _messages.divisions.two,
                            3 => _messages.divisions.three,
                            _ => _messages.divisions.four,
                          }}',
                        ),
                        TextButton(
                          onPressed: () => context.goNamed(GamePage.routeName),
                          child: const Text('START'),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.read<EloCubit>().increase(100),
                          child: const Text('Add'),
                        ),
                        TextButton(
                          onPressed: () => context.read<EloCubit>().reset(),
                          child: const Text('RESET'),
                        ),
                      ],
                    ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  RankedPagesMessages get _messages => Injector.instance.messages.pages.ranked;
}
