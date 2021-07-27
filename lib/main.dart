import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/home_screen_model.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';

final _m1 = UnitStack.fromJson({
  'id': '123',
  'type': UnitType.banditGuard,
  'availableNumbersPull': [1, 3, 4, 5, 6],
  'units': [
    {
      'displayName': 'bandit',
      'healthPoint': 10,
      'number': 2,
    }
  ],
});
final _m2 = UnitStack.fromJson({
  'id': '111',
  'type': UnitType.banditGuard,
  'availableNumbersPull': [1, 3, 4, 5, 6],
  'units': [
    {
      'displayName': 'bandit',
      'healthPoint': 10,
      'number': 2,
    }
  ],
});

final monstersMock = <UnitStack>[_m1, _m2];

void main() {
  setupDI();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenModel(monsters: monstersMock),
      child: CupertinoApp(
        title: 'Gloomhaven Battle Assistant',
        theme: CupertinoThemeData(
          scaffoldBackgroundColor: Colors.white,
          // primaryColor: Colors.amberAccent,
          // scaffoldBackgroundColor: Colors.brown,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
