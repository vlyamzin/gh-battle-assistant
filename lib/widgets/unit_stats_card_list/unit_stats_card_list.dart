import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/grid.dart';
import 'package:gh_battle_assistant/controllers/activity_tooltip_provider.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/widgets/unit_stats_card/unit_stats_card.dart';
import 'package:provider/provider.dart';

import '../../di.dart';

class UnitActionCardList extends StatefulWidget {
  const UnitActionCardList({
    Key? key,
    required this.stack,
    required this.defaultStats,
  }) : super(key: key);

  final UnitStack stack;
  final Map<UnitNormality, UnitRawStats> defaultStats;

  @override
  _UnitActionCardListState createState() => _UnitActionCardListState();
}

class _UnitActionCardListState extends State<UnitActionCardList> {
  @override
  Widget build(BuildContext context) {
    return Grid(
      landscape: 2,
      portrait: 1,
      childWidth: 1.8,
      childHeight: 1,
      children: _unitCards(),
    );
  }

  void _gotoHomeScreen(BuildContext context) => Navigator.of(context).pop();

  List<Widget> _unitCards() {
    return widget.stack.units.map((unit) {
      final UnitRawStats? stats = unit.elite == true
          ? widget.defaultStats[UnitNormality.elite]
          : widget.defaultStats[UnitNormality.normal];

      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UnitStatsProvider>(
            create: (BuildContext context) => UnitStatsProvider(
              unit: unit,
              modifiers: widget.stack.actions.currentAction?.modifiers ?? {},
              defaultStats: stats!,
            ),
          ),
          ChangeNotifierProxyProvider<UnitStatsProvider,
              ActivityTooltipProvider>(
            create: (_) => ActivityTooltipProvider.empty(),
            update: (_, unitStats, tooltip) {
              var activityType = unitStats.selectedActivity.key;
              var counter = unitStats.counter;

              return tooltip!
                  .copyWith(activityType: activityType, counter: counter)
                ..toggleTooltip();
            },
          ),
        ],
        child: UnitStatsCard(
          key: ValueKey(unit.number),
          width: 500,
          height: 400,
          unit: unit,
          type: widget.stack.type,
          onRemove: () => _removeUnitFromStack(unit.number, context),
        ),
      );
    }).toList();
  }

  void _removeUnitFromStack(int? unitNumber, BuildContext context) {
    assert(unitNumber != null);
    final homeController = di<HomeScreenProvider>();

    widget.stack.removeUnitOld(unitNumber!);

    if (widget.stack.isEmpty) {
      homeController.removeMonsterStack(widget.stack.type);
      _gotoHomeScreen(context);
    } else {
      homeController.saveToStorage().then((_) => setState(() {}));
    }
  }
}
