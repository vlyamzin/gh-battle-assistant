import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/pull_to_refresh.dart';
import 'package:gh_battle_assistant/common/sliver_grid.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/home_screen_events.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/stats_screen.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/unit_action_card.dart';
import 'package:gh_battle_assistant/screens/add_unit_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: PullToRefresh(
        onRefresh: () async {
          await _refreshUnitActions(context);
        },
        child: _gridView(context),
        header: _navBar(context),
      ),
    );
  }

  Future<void> _refreshUnitActions(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    context.read<HomeScreenProvider>().emit(HomeScreenEvents.NEW_ACTIONS);
  }

  CupertinoSliverNavigationBar _navBar(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: const Text('Gloomhaven Battle Assistant'),
      trailing: Container(
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).push(_addUnitRoute()),
          child: Text('Add Unit'),
        ),
      ),
    );
  }

  /// Add extra route with [AddUnitScreen] widget
  CupertinoPageRoute _addUnitRoute() {
    return CupertinoPageRoute(builder: (_) => AddUnitScreen());
  }

  PageRouteBuilder _unitStatsRoute(UnitStack stack, GameData rawData) {
    final Map<UnitNormality, UnitRawStats>? unitStats =
        rawData.getUnitDataById(stack.type).getUnitStats(difficulty);

    if (unitStats != null) {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => StatsScreen(
          stack: stack,
          defaultStats: unitStats,
        ),
      );
    } else
      throw StateError(
        'Cannot get unit stats for level $difficulty of unit ${stack.displayName}',
      );
  }

  /// Create [GridView] widget with unit cards in it
  Widget _gridView(BuildContext context) {
    final cardWidth = _screenSize(context) / 2;
    final double cardHeight =
        MediaQuery.of(context).orientation == Orientation.portrait ? 300 : 400;
    final rawData = context.read<GameData>();

    return Consumer<HomeScreenProvider>(
      builder: (context, provider, _) {
        return GHSliverGrid(
          padding: 8.0,
          landscape: 3,
          portrait: 2,
          children: provider.model.monsters.map((UnitStack stack) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_unitStatsRoute(stack, rawData));
                },
                child: Hero(
                  tag: 'stats_${stack.type}',
                  child: _initProviders(
                    context: context,
                    unitStack: stack,
                    store: provider,
                    child: UnitActionCard(
                      key: ValueKey(stack.type),
                      width: cardWidth,
                      height: cardHeight,
                    ),
                  ),
                ));
          }).toList(),
          childWidth: cardWidth,
          childHeight: cardHeight,
        );
      },
    );
  }

  Widget _initProviders({
    required BuildContext context,
    required UnitStack unitStack,
    required HomeScreenProvider store,
    required Widget child,
  }) {
    final gameDataProvider = context.read<GameData>();
    final List<UnitRawAction> rawData =
        gameDataProvider.getUnitDataById(unitStack.type).actions;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UnitActionProvider>(
          create: (context) {
            return UnitActionProvider(
                actions: unitStack.actions, store: store, rawData: rawData);
          },
        ),
        ChangeNotifierProxyProvider<UnitActionProvider, UnitStackProvider>(
          create: (context) {
            return UnitStackProvider(
                store: store, unitStack: unitStack, gameData: gameDataProvider);
          },
          update: (context, actionProvider, stackProvider) {
            final currentAction = actionProvider.actions.currentAction;
            stackProvider?.refreshStatsToDefault();
            stackProvider?.applyModifiers(currentAction?.modifiers);
            return stackProvider ??
                UnitStackProvider(
                    store: store,
                    unitStack: unitStack,
                    gameData: gameDataProvider);
          },
        )
      ],
      child: child,
    );
  }

  /// Get screen size
  double _screenSize(BuildContext context) => MediaQuery.of(context).size.width;
}
