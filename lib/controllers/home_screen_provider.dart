import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/home_screen_events.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/home.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/services/store_service.dart';

class HomeScreenProvider with ChangeNotifier {
  Home model;
  StreamController<HomeScreenEvents> _eventEmitter;

  HomeScreenProvider({required this.model}): _eventEmitter = StreamController.broadcast();

  factory HomeScreenProvider.fromJson(Map<String, dynamic> json) {
    return HomeScreenProvider(model: Home.fromJson(json));
  }

  factory HomeScreenProvider.empty() {
    return HomeScreenProvider(model: Home());
  }

  Stream get event$ => _eventEmitter.stream;

  Future<void> saveToStorage() async {
    final data = model.toJson();
    await di<StoreService>().write(data);
  }

  void emit(HomeScreenEvents action) {
    _eventEmitter.sink.add(action);
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

  @override
  void dispose() {
    _eventEmitter.close();
    super.dispose();
  }
}
