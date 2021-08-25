import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/home.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/services/store_service.dart';

class HomeScreenProvider with ChangeNotifier {
  Home model;

  HomeScreenProvider({required this.model});

  factory HomeScreenProvider.fromJson(Map<String, dynamic> json) {
    return HomeScreenProvider(model: Home.fromJson(json));
  }

  factory HomeScreenProvider.empty() {
    return HomeScreenProvider(model: Home());
  }

  Future<void> saveToStorage() async {
    final data = model.toJson();
    await di<StoreService>().write(data);
  }

  void addMonsterStack(UnitStack data) {
    var stack = model.getByType(data.type);
    if (stack != null)
      stack = data;
    else
      model.add(data);

    // save locally
    saveToStorage().then((value) => {notifyListeners()});
  }

  void removeMonsterStack(UnitType type) {
    model.remove(type);
    saveToStorage().then((value) => {notifyListeners()});
  }
}
