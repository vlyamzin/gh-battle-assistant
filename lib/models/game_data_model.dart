import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class GameDataModel with ChangeNotifier {
  final List<UnitStack> monsters;

  GameDataModel({monsters}): this.monsters = monsters ?? [];

  UnitStack? getByType(UnitType type) {
    return monsters.firstWhere((element) => element.type == type );
  }

  void addMonsterStack(UnitStack stack) {
    monsters.add(stack);
    notifyListeners();
  }

  void removeMonsterStack(String id) {
    monsters.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
