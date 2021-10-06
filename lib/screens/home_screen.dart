import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/pull_to_refresh.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/controllers/settings_controller.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';
import 'package:gh_battle_assistant/common/sliver_grid.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/home_screen_events.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/stats_screen.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/stack_card/stack_card.dart';
import 'package:gh_battle_assistant/screens/add_unit_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(ImageService.mainBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: PullToRefresh(
          onRefresh: () async {
            await _refreshUnitActions(context);
          },
          child: _gridView(context),
          header: _navBar(context),
        ),
      ),
    );
  }

  Future<void> _refreshUnitActions(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    context.read<HomeScreenProvider>().emit(HomeScreenEvents.NEW_ACTIONS);
  }

  CupertinoSliverNavigationBar _navBar(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: Color(0xFF3C4659),
      leading: Container(
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(Icons.settings),
          onPressed: () => _showSettings(context),
        ),
      ),
      largeTitle: const Text(
        'Gloomhaven Battle Assistant',
        style: const TextStyle(
          fontFamily: 'PirataOne',
          color: Color(0xFFC2ECF2),
          letterSpacing: 3,
        ),
      ),
      trailing: Container(
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _navigateToAddUnitRoute(context),
          child: Text('Add Unit'),
        ),
      ),
    );
  }

  void _navigateToAddUnitRoute(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => AddUnitScreen()));
  }

  void _navigateToUnitStatsScreen(
    BuildContext context,
    UnitStack stackModel,
    GameData rawData,
  ) {
    final difficulty = di<SettingsController>().difficulty.toString();
    final Map<UnitNormality, UnitRawStats>? unitStats =
        rawData.getUnitDataById(stackModel.type).getUnitStats(difficulty);

    if (unitStats != null) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => StatsScreen(
            stack: stackModel,
            defaultStats: unitStats,
          ),
        ),
      );
    } else
      throw StateError(
        'Cannot get unit stats for level $difficulty of unit ${stackModel.displayName}',
      );
  }

  void _showSettings(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SettingsDialog();
        });
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
                onTap: () =>
                    _navigateToUnitStatsScreen(context, stack, rawData),
                child: StackCard(
                  stack: stack,
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                ));
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
