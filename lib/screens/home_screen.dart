import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/common/pull_to_refresh.dart';
import 'package:gh_battle_assistant/common/sliver_grid.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/enums/home_screen_events.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card.dart';
import 'package:gh_battle_assistant/screens/add_unit_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: PullToRefresh(
        onRefresh: () async { await _refreshUnitActions(context); },
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

  /// Create [GridView] widget with unit cards in it
  Widget _gridView(BuildContext context) {
    final cardWidth = _screenSize(context) / 2;
    final double cardHeight =
        MediaQuery.of(context).orientation == Orientation.portrait ? 300 : 400;

    return Consumer<HomeScreenProvider>(
      builder: (context, provider, _) {
        return GHSliverGrid(
          padding: 8.0,
          landscape: 3,
          portrait: 2,
          children: provider.model.monsters.map((UnitStack stack) {
            return Provider<UnitStack>.value(
              value: stack,
              child: UnitActionCard(
                key: ValueKey(stack.type),
                monster: stack,
                width: cardWidth,
                height: cardHeight,
              ),
            );
          }).toList(),
          childWidth: cardWidth,
          childHeight: cardHeight,
        );
      },
    );
  }

  /// Get screen size
  double _screenSize(BuildContext context) => MediaQuery.of(context).size.width;
}
