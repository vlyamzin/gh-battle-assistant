import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/unit.dart';

import '../di.dart';

class UnitStatsProvider with ChangeNotifier {
  final Unit unit;
  final HomeScreenProvider _homeScreenProvider;

  UnitStatsProvider({required this.unit}) : this._homeScreenProvider = di<HomeScreenProvider>();

  void save() {
    _homeScreenProvider.saveToStorage().then((_) => notifyListeners());
  }
}
