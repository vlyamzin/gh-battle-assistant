import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
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

    return MultiProvider(
      providers: [
        Provider<UnitStackProvider>(
          key: key,
          create: (context) {
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
