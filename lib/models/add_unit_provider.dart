import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/game_data_model.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

enum FormStatus { submitted, pristine }

class AddUnitScreenProvider with ChangeNotifier {
  FormStatus _formStatus = FormStatus.pristine;

  FormStatus get formStatus => _formStatus;

  set formStatus(FormStatus status) {
    _formStatus = status;
    notifyListeners();
  }
}

class AddUnitProvider {
  final GameData data;
  UnitStack? stack;
  UnitRawData? unit;
  int unitNumber = 0, eliteNumber = 0;

  AddUnitProvider({required this.data});

  Map<UnitType, String> getUnitNames() {
    return Map.fromIterable(data.monsters,
        key: (e) => e.id, value: (e) => e.name);
  }

  Map<UnitType, String> getSuggestions(String query) {
    var matches = <UnitType, String>{};
    matches.addAll(getUnitNames());

    matches.removeWhere(
        (_, value) => !value.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  MapEntry<UnitType, String>? getUnitByName(String query) {
    unit = data.getUnitDataByName(query);
    return MapEntry(unit!.id, unit!.name);
  }

  UnitStack initUnitStack(
      UnitType type, String unitName, GameDataModel gameModel) {
    stack = gameModel.monsters.firstWhere((element) => element.type == type,
        orElse: () => UnitStack.withId(
            type: type,
            displayName: unitName,
            maxNumber: data.getUnitDataById(type).maxNumber));

    return stack!;
  }

  void clearUnitStack() {
    stack = null;
  }

  int getMaxUnitNumberToAdd() {
    if (stack != null) {
      return stack?.maxNumber ?? 0;
    } else {
      return unit?.maxNumber ?? 0;
    }
  }

  void addUnitsToStack() {
    assert(stack != null);
    if (stack == null)
      throw StateError('[AddUnitProvider]: Stack is not defined');

    var eliteCount = eliteNumber;
    var normalCount = unitNumber;
    final statsByDifficulty = () => unit?.stats[difficulty];
    final statsByNormality = (bool elite) => elite
        ? statsByDifficulty()![UnitNormality.elite]
        : statsByDifficulty()![UnitNormality.normal];

    while (eliteCount > 0) {
      stack!.addUnit(_createUnit(unit!.name, statsByNormality(true)!, true));
      --eliteCount;
      --normalCount;
    }

    for (var i = 0; i < normalCount; i++) {
      stack!.addUnit(_createUnit(unit!.name, statsByNormality(false)!, false));
    }
  }

  Unit _createUnit(String name, UnitRawStats data, bool elite) {
    return Unit(
        elite: elite,
        displayName: name,
        healthPoint: data.health,
        shield: data.shield,
        attack: data.attack,
        move: data.move,
        range: data.range);
  }
}