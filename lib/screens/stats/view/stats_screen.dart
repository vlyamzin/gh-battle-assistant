import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/common/grid.dart';
import 'package:gh_battle_assistant/common/enums/turn_state.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class StatsScreen extends StatelessWidget {
  final UnitStack stack;
  final EnemiesBloc enemiesBloc;

  const StatsScreen({
    Key? key,
    required this.enemiesBloc,
    required this.stack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget;

    widget = CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF3C4659),
        leading: _NavigationGuard(),
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
    var createWidget = (context, stack) => Grid(
          landscape: 2,
          portrait: 1,
          children: _cards(context, stack.units),
        );

    return Builder(builder: (context) {
      return BlocListener<StatsCubit, StatsState>(
        // Navigate back to the Home screen when state changed to 'navigateBack'
        // It happens when there are no units left in the stack
        listener: (context, state) {
          state.maybeWhen(
            navigateBack: () {
              Navigator.pop(context);
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<StatsCubit, StatsState>(builder: (_, state) {
          return state.when(
            initial: (stack) => createWidget(context, stack),
            turnStarted: (stack) => createWidget(context, stack),
            turnEnded: (stack) => createWidget(context, stack),
            navigateBack: () => Container(),
          );
        }),
      );
    });
  }

  List<Widget> _cards(BuildContext context, List<Unit> units) {
    return units
        .map(
          (unit) => BlocProvider<UnitCubit>(
            key: ValueKey(unit.number),
            create: (_) => UnitCubit(
              unit: unit,
              statsCubit: context.read<StatsCubit>(),
              onStateChanged: (newUnit) =>
                  context.read<StatsCubit>().unitChanged(newUnit),
              onUnitRemoved: (unitNumber) =>
                  context.read<StatsCubit>().unitRemoved(unitNumber),
            ),
            child: Builder(builder: (context) {
              return UnitStatsCard(
                width: 500,
                height: 400,
                type: stack.type,
              );
            }),
          ),
        )
        .toList();
  }

  Widget _turnActionButton(BuildContext context) {
    final createButton = (Function? action, String label) {
      return Container(
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => action != null ? action() : null,
          child: Text(label),
        ),
      );
    };

    try {
      final cubit = context.watch<StatsCubit>();

      return cubit.state.when(
        initial: (_) {
          return createButton(cubit.startTurn, 'Start Turn');
        },
        turnStarted: (_) {
          return createButton(cubit.endTurn, 'End Turn');
        },
        turnEnded: (_) {
          return createButton(null, 'Turn Ended');
        },
        navigateBack: () {
          return Container();
        },
      );
    } catch (_) {
      return Container();
    }
  }
}

class _NavigationGuard extends StatelessWidget {
  const _NavigationGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return CupertinoNavigationBarBackButton(
        onPressed: () {
          var cubit = context.read<StatsCubit>();
          if (cubit.turnStarted) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text('End ${cubit.stack.displayName} turn?'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('No'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: const Text('Yes'),
                    onPressed: () {
                      cubit.endTurn();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ).then((_) => Navigator.pop(context));
          } else {
            Navigator.pop(context);
          }
        },
      );
    });
  }
}
