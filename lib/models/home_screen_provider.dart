import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class HomeScreenProvider with ChangeNotifier {
  final List<UnitStack> _monsters;

  HomeScreenProvider({monsters}): this._monsters = monsters ?? [];

  List<UnitStack> get monsters => List.unmodifiable(_monsters);

  UnitStack? getByType(UnitType type) {
    try {
      return monsters.firstWhere((element) => element.type == type);
    } on StateError catch(_) {
      return null;
    }
  }

  void addMonsterStack(UnitStack data) {
    var stack = getByType(data.type);
    if (stack != null) stack = data;
    else _monsters.add(data);

    notifyListeners();
  }

  void removeMonsterStack(UnitType type) {
    _monsters.removeWhere((element) => element.type == type);
    notifyListeners();
  }
}
