import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/unit_action_card.dart';
import 'package:provider/provider.dart';

/// Initializes [UnitStackProvider] and [UnitActionProvider] provider
/// to manipulate with [UnitStack] and [UnitActionList] models
class StackCard extends StatelessWidget {
  final UnitStack stack;
  final double cardWidth;
  final double cardHeight;
  const StackCard({
    Key? key,
    required this.stack,
    required this.cardWidth,
    required this.cardHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _initProviders(
        context: context,
        child: UnitActionCard(
          key: ValueKey(stack.type),
          width: cardWidth,
          height: cardHeight,
        ),
      ),
    );
  }

  Widget _initProviders({
    required BuildContext context,
    required Widget child,
  }) {
    final store = context.read<HomeScreenProvider>();
    final gameDataController = context.read<GameData>();
    final List<UnitRawAction> rawData =
        gameDataController.getUnitDataById(stack.type).actions;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UnitActionProvider>(
          create: (_) => UnitActionProvider(
            actions: stack.actions,
            store: store,
            rawData: rawData,
          ),
        ),
        ProxyProvider2<UnitActionProvider, HomeScreenProvider,
            UnitStackProvider>(
          update: (_, unitActionC, homeScreenC, unitStackC) {
            var action = unitActionC.actions.currentAction;
            var updatedStack = homeScreenC.model.getByType(stack.type);

            if (unitStackC != null && action != null)
              return unitStackC
                ..updateStack(updatedStack!)
                ..endRound(action);
            if (action != null)
              return UnitStackProvider(
                gameData: gameDataController,
                unitStack: stack,
                store: store,
              )
                ..applyModifiers(action.modifiers)
                ..applyPerks(action.perks)
                ..applyArea(action.area);
            else
              return UnitStackProvider(
                gameData: gameDataController,
                unitStack: stack,
                store: store,
              );
          },
        ),
      ],
      child: child,
    );
  }
}
