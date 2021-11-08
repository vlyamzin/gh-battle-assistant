import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/grid.dart';
import 'package:gh_battle_assistant/models/enums/turn_state.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class StatsScreen extends StatelessWidget {
  final UnitStack stack;
  final EnemiesBloc enemiesBloc;
  @deprecated
  final Map<UnitNormality, UnitRawStats> defaultStats;

  const StatsScreen({
    Key? key,
    required this.enemiesBloc,
    required this.stack,
    required this.defaultStats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget;

    widget = CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF3C4659),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          stack.displayName,
          style: TextStyle(
            color: Color(0xFFC2ECF2),
            fontSize: 25,
            fontFamily: 'PirataOne',
            fontWeight: FontWeight.normal,
            letterSpacing: 2.5,
          ),
        ),
        trailing: Builder(
          builder: (context) => _turnActionButton(context),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageService.mainBackground), fit: BoxFit.fill),
        ),
        // child: UnitActionCardList(
        //   defaultStats: defaultStats,
        //   stack: stack,
        // ),
        child: _grid(),
      ),
    );

    widget = BlocProvider<StatsCubit>(
      create: (context) {
        switch (stack.turnState) {
          case TurnState.idle:
            return StatsCubit(enemiesBloc, stack);
          case TurnState.started:
            return StatsCubit.started(enemiesBloc, stack);
          case TurnState.ended:
            return StatsCubit.ended(enemiesBloc, stack);
        }
      },
      lazy: false,
      child: widget,
    );
    return widget;
  }

  Widget _grid() {
    var widget = (stack) => Grid(
          landscape: 2,
          portrait: 1,
          children: _cards(stack.units),
        );

    return Builder(builder: (context) {
      return BlocBuilder<StatsCubit, StatsState>(builder: (_, state) {
        return state.when(
          initial: (stack) => widget(stack),
          turnStarted: (stack) => widget(stack),
          turnEnded: (stack) => widget(stack),
        );
      });
    });
  }

  List<Widget> _cards(List<Unit> units) {
    return units
        .map(
          (unit) => UnitStatsCard(
            key: ValueKey(unit.number),
            width: 500,
            height: 400,
            unit: unit,
            type: stack.type,
            onRemove: () => null,
          ),
        )
        .toList();
  }

  Widget _turnActionButton(BuildContext context) {
    try {
      final cubit = context.watch<StatsCubit>();

      return cubit.state.when(initial: (_) {
        return Container(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => cubit.startTurn(),
            child: Text('Start Turn'),
          ),
        );
      }, turnStarted: (_) {
        return Container(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => cubit.endTurn(),
            child: Text('End Turn'),
          ),
        );
      }, turnEnded: (_) {
        return Container(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => null,
            child: Text('Turn Ended'),
          ),
        );
      });
    } catch (_) {
      return Container();
    }
  }
}
