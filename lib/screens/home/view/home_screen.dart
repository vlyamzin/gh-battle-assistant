import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/pull_to_refresh.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';
import 'package:gh_battle_assistant/common/sliver_grid.dart';
import 'package:gh_battle_assistant/common/enums/unit_normality.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        state.maybeWhen(
            newGame: (Settings settings) {
              if (settings.newGame) {
                context.read<EnemiesBloc>().add(ClearEnemiesList());
              }
              context.read<SettingsBloc>().add(SettingsSaveE());
            },
            orElse: () {});
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
      },
    );
  }

  Future<void> _refreshUnitActions(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    var enemiesBloc = context.read<EnemiesBloc>()..add(NewActionRequested());

    // update settings.newGame if it was set to 'true'
    // it means that game is active now and first round begins
    try {
      var settings = context.read<SettingsRepository>().loadSettings();
      if (settings.newGame && enemiesBloc.state is EnemiesLoaded)
        context.read<SettingsBloc>().add(StartNewGame(false));
    } catch (e) {
      di<LoggerService>().log('Settings are not loaded yet', this.runtimeType);
    }
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
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (_) => AddUnitScreen(
              enemiesBloc: context.read<EnemiesBloc>(),
            )));
  }

  void _navigateToUnitStatsScreen(
    BuildContext context,
    UnitStack stackModel,
    GameData rawData,
  ) {
    try {
      final settings = context.read<SettingsRepository>().loadSettings();
      final difficulty = settings.difficulty.toString();
      // TODO possibly unused variable
      final Map<UnitNormality, UnitRawStats>? unitStats =
          rawData.getUnitDataById(stackModel.type).getUnitStats(difficulty);

      if (unitStats != null) {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => StatsScreen(
              enemiesBloc: context.read<EnemiesBloc>(),
              stack: stackModel,
            ),
          ),
        );
      } else
        di<LoggerService>().log(
            'Cannot get unit stats for level $difficulty of unit ${stackModel.displayName}');
    } catch (e) {
      di<LoggerService>().log(e.toString(), this.runtimeType);
    }
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

    return BlocBuilder<EnemiesBloc, EnemiesState>(
      builder: (context, state) {
        return state.when(
          initial: () => SliverGrid.count(crossAxisCount: 1),
          loaded: (Enemies enemies) {
            return GHSliverGrid(
              padding: 8.0,
              landscape: 3,
              portrait: 2,
              children: enemies.monsters.map((UnitStack stack) {
                return GestureDetector(
                    onTap: () =>
                        _navigateToUnitStatsScreen(context, stack, rawData),
                    child: Provider<UnitStack>.value(
                      value: stack,
                      child: UnitActionCard(
                        key: ValueKey(stack.type),
                        width: cardWidth,
                        height: cardHeight,
                      ),
                    ));
              }).toList(),
              childWidth: cardWidth,
              childHeight: cardHeight,
            );
          },
        );
      },
    );
  }

  /// Get screen size
  double _screenSize(BuildContext context) => MediaQuery.of(context).size.width;
}
