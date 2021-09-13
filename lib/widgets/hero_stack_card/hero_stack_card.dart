import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/unit_action_card.dart';
import 'package:provider/provider.dart';

/// Creates [Hero] widget with [UnitActionCard] inside of it
/// Initializes [UnitStackProvider] and [UnitActionProvider] provider
/// to manipulate with [UnitStack] and [UnitActionList] models
class HeroStackCard extends StatelessWidget {
  final UnitStack stack;
  final double cardWidth;
  final double cardHeight;
  const HeroStackCard({
    Key? key,
    required this.stack,
    required this.cardWidth,
    required this.cardHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'stats_${stack.type}',
        child: _initProviders(
          context: context,
          child: UnitActionCard(
            key: ValueKey(stack.type),
            width: cardWidth,
            height: cardHeight,
          ),
        ));
  }

  Widget _initProviders({
    required BuildContext context,
    required Widget child,
  }) {
    final store = context.read<HomeScreenProvider>();
    final gameDataProvider = context.read<GameData>();
    final unitStackProvider = UnitStackProvider(
        store: store, unitStack: stack, gameData: gameDataProvider);
    final List<UnitRawAction> rawData =
        gameDataProvider.getUnitDataById(stack.type).actions;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UnitStackProvider>.value(
            value: unitStackProvider),
        ChangeNotifierProvider<UnitActionProvider>(
          create: (context) {
            return UnitActionProvider(
              actions: stack.actions,
              store: store,
              rawData: rawData,
              stackProvider: unitStackProvider,
            );
          },
        ),
      ],
      child: child,
    );
  }
}
