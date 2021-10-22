import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/unit_action_card.dart';
import 'package:provider/provider.dart';

class StackCard extends StatelessWidget {
  final Key key;
  final UnitStack stack;
  final double cardWidth;
  final double cardHeight;
  const StackCard({
    required this.key,
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
          key: key,
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
        ProxyProvider2<UnitActionProvider, HomeScreenProvider,
            UnitStackProvider>(
          key: key,
          update: (_, unitActionC, homeScreenC, unitStackC) {
            var action = unitActionC.actions.currentAction;
            var updatedStack = homeScreenC.model.getByType(stack.type);

            // Mid-game. Controllers are initialized, new action or new stack appears
            if (unitStackC != null && action != null) return unitStackC;
            // ..updateStack(updatedStack!)
            // ..endRound(action);
            // Fresh load with data. Action already created but UnitStackController is not initialized yet
            if (action != null)
              return UnitStackProvider(
                gameData: gameDataController,
                unitStack: stack,
                store: store,
                currentAction: action,
              );
            // ..applyModifiers(action.modifiers)
            // ..applyPerks(action.perks)
            // ..applyArea(action.area);
            // Backup initializer
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
