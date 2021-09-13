import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class UnitStackProvider with ChangeNotifier {
  final UnitStack unitStack;
  final HomeScreenProvider store;
  final GameData gameData;
  late final StatsByUnitNormalityMap? _defaultStats;

  UnitStackProvider({
    required this.unitStack,
    required this.store,
    required this.gameData,
  }) : _defaultStats = gameData.getUnitDataById(unitStack.type).getUnitStats();

  void applyModifiers(Map<ModifierType, int>? modifiers) {
    if (modifiers != null) {
      modifiers.entries.forEach((modifier) {
        unitStack.units.forEach((Unit unit) {
          switch (modifier.key) {
            case ModifierType.attack:
              if (unit.attack != null)
                unit.attack = unit.attack! + modifier.value;
              break;
            case ModifierType.move:
              if (unit.move != null) unit.move = unit.move! + modifier.value;
              break;
            case ModifierType.range:
              if (unit.range != null) unit.range = unit.range! + modifier.value;
              break;
            case ModifierType.shield:
              if (unit.shield != null)
                unit.shield = unit.shield! + modifier.value;
              break;
            case ModifierType.retaliate:
              if (unit.retaliate != null)
                unit.retaliate = unit.retaliate! + modifier.value;
              break;
            default:
              break;
          }
        });
      });
    }
  }

  void refreshStatsToDefault() {
    if (_defaultStats == null)
      throw StateError(
          'Unit Stack Provider: Default unit stats are not defined');

    unitStack.units.forEach((unit) {
      final normality = unit.elite ? UnitNormality.elite : UnitNormality.normal;

      try {
        unit.attack = _defaultStats![normality]!.attack;
        unit.range = _defaultStats![normality]!.range;
        unit.move = _defaultStats![normality]!.move;
        unit.shield = _defaultStats![normality]!.shield;
        unit.retaliate = _defaultStats![normality]!.retaliate;

        unit.perks?.clear();
        unit.perks?.addAll(_defaultStats![normality]?.perks ?? []);
      } catch (error) {
        print('Unit Stack Provider: Default stats error $error');
      }
    });
  }
}
