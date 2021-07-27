import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class HomeScreenModel with ChangeNotifier {
  final List<UnitStack> monsters;

  HomeScreenModel({monsters}): this.monsters = monsters ?? [];

  void addMonsterStack(UnitStack stack) {
    monsters.add(stack);
    notifyListeners();
  }

  void removeMonsterStack(String id) {
    monsters.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
