import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/home.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/controllers/settings_controller.dart';

class AddUnitProvider {
  final GameData data;
  UnitStack? stack;
  List<Unit> tempUnits = [];
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

  UnitStack initUnitStack(UnitType type, String unitName, Home gameModel) {
    var _stack = gameModel.getByType(type);
    stack = _stack != null
        ? UnitStack.copy(_stack)
        : UnitStack.fromRawData(data.getUnitDataById(type));

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
    if (stack == null)
      throw StateError('[AddUnitProvider]: Stack is not defined');

    var eliteCount = eliteNumber;
    var normalCount = unitNumber;
    final difficulty = di<SettingsController>().difficulty.toString();
    final statsByDifficulty = () => unit?.stats[difficulty];
    final statsByNormality = (bool elite) => elite
        ? statsByDifficulty()![UnitNormality.elite]
        : statsByDifficulty()![UnitNormality.normal];

    while (eliteCount > 0) {
      final _unit = _createUnit(unit!.name, statsByNormality(true)!, true);
      stack!.addUnit(_unit);
      tempUnits.add(_unit);
      --eliteCount;
      --normalCount;
    }

    for (var i = 0; i < normalCount; i++) {
      final _unit = _createUnit(unit!.name, statsByNormality(false)!, false);
      stack!.addUnit(_unit);
      tempUnits.add(_unit);
    }
  }

  Unit _createUnit(String name, UnitRawStats data, bool elite) {
    return Unit.fromRawData(
      elite: elite,
      displayName: name,
      healthPoint: data.health,
      shield: data.shield,
      attack: data.attack,
      move: data.move,
      turnEnded: false,
      retaliate: data.retaliate,
      range: data.range,
      perks: data.perks,
      immune: data.immune,
    );
  }
}
