import 'package:get_it/get_it.dart';
import 'package:gh_battle_assistant/models/home_screen_model.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';


final _m1 = UnitStack.fromJson({
  'id': '123',
  'type': UnitType.banditGuard,
  'availableNumbersPull': [1,3,4,5,6],
  'units': [{'displayName': 'bandit', 'healthPoint': 10, 'number': 2,}],
});
final _m2 = UnitStack.fromJson({
  'id': '111',
  'type': UnitType.banditGuard,
  'availableNumbersPull': [1,3,4,5,6],
  'units': [{'displayName': 'bandit', 'healthPoint': 10, 'number': 2,}],
});

final _monstersMock = <UnitStack>[_m1, _m2];

GetIt di = GetIt.instance;

void setupDI() {
  // di.registerSingleton(Instance())
  di.registerSingleton<HomeScreenModel>(HomeScreenModel(monsters: _monstersMock));
  di.registerFactoryParam<UnitAction, UnitType, void>((type, _) => UnitAction(type: type));
}
