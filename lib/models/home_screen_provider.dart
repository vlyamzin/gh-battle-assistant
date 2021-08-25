import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/services/store_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_screen_provider.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeScreenProvider with ChangeNotifier {
  List<UnitStack> _monsters;

  HomeScreenProvider({List<UnitStack>? monsters}) : this._monsters = monsters ?? [];

  factory HomeScreenProvider.fromJson(Map<String, dynamic> json) =>
      _$HomeScreenProviderFromJson(json);

  Future<void> saveToStorage() async {
    final data = _$HomeScreenProviderToJson(this);
    await di<StoreService>().write(data);
  }

  List<UnitStack> get monsters => List.unmodifiable(_monsters);

  UnitStack? getByType(UnitType type) {
    try {
      return monsters.firstWhere((element) => element.type == type);
    } on StateError catch (_) {
      return null;
    }
  }

  void addMonsterStack(UnitStack data) {
    var stack = getByType(data.type);
    if (stack != null)
      stack = data;
    else
      _monsters.add(data);

    // save locally
    saveToStorage().then((value) => {notifyListeners()});
  }

  void removeMonsterStack(UnitType type) {
    _monsters.removeWhere((element) => element.type == type);
    saveToStorage().then((value) => {notifyListeners()});
  }
}
