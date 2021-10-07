import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class UnitStackProvider {
  UnitStack unitStack;
  final GameData gameData;
  final HomeScreenProvider store;
  late final StatsByUnitNormalityMap? _defaultStats;

  UnitStackProvider({
    required this.unitStack,
    required this.gameData,
    required this.store,
  }) {
    _defaultStats = gameData.getUnitDataById(unitStack.type).getUnitStats();
  }

  void updateStack(UnitStack newStack) {
    if (newStack.units.length != unitStack.units.length) unitStack = newStack;
  }

  void endRound(UnitAction action) {
    applyNegativeEffect();
    refreshStatsToDefault();
    _applyChanges(action);
    store.saveToStorage();
  }

  void applyModifiers(Map<ModifierType, int>? modifiers) {
    if (modifiers != null) {
      // if action does not have attack || range || move modifiers
      // then these stats must be set to null
      // default unit stats values are ignored
      var _modifiers = {..._emptyModifiers, ...modifiers};

      _modifiers.entries.forEach((modifier) {
        unitStack.units.forEach((Unit unit) {
          switch (modifier.key) {
            case ModifierType.attack:
              if (modifier.value == null) {
                unit.attack = null;
                return;
              }
              if (unit.attack != null)
                unit.attack = unit.attack! + modifier.value!;
              else
                unit.attack = modifier.value!;
              break;
            case ModifierType.move:
              if (modifier.value == null) {
                unit.move = null;
                return;
              }
              if (unit.move != null)
                unit.move = unit.move! + modifier.value!;
              else
                unit.move = modifier.value!;
              break;
            case ModifierType.range:
              if (modifier.value == null) {
                unit.range = null;
                return;
              }
              if (unit.range != null)
                unit.range = unit.range! + modifier.value!;
              else
                unit.range = modifier.value!;
              break;
            case ModifierType.shield:
              unit.shield = unit.shield + modifier.value!;
              break;
            case ModifierType.retaliate:
              if (unit.retaliate != null)
                unit.retaliate = unit.retaliate! + modifier.value!;
              else
                unit.retaliate = modifier.value;
              break;
            case ModifierType.suffer:
              unit.suffer = modifier.value!;
              break;
            case ModifierType.heal:
              unit.heal = modifier.value!;
              break;
            default:
              break;
          }
        });
      });
    }
  }

  void applyPerks(List<ActivityType>? perks) {
    if (perks != null) {
      unitStack.units.forEach((unit) => unit.perks?.addAll(perks));
    }
  }

  void applyArea(List<String>? area) {
    if (area != null) {
      unitStack.units.forEach((unit) => unit.area.addAll(area));
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
        unit.shield = _defaultStats![normality]?.shield ?? 0;
        unit.retaliate = _defaultStats![normality]!.retaliate;

        unit.perks?.clear();
        unit.area.clear();
        unit.perks?.addAll(
            Unit.serializeRawData(_defaultStats![normality]?.perks) ?? []);
        unit.turnEnded = false;
      } catch (error) {
        print('Unit Stack Provider: Default stats error $error');
      }
    });
  }

  void applyNegativeEffect() {
    unitStack.units.forEach((unit) => unit.applyNegativeEffects());
  }

  void validateDeath() {
    unitStack.units.removeWhere((unit) => unit.healthPoint <= 0);
  }

  void _applyChanges(UnitAction action) {
    applyModifiers(action.modifiers);
    applyPerks(action.perks);
    applyArea(action.area);
    validateDeath();
  }

  Map<ModifierType, int?> get _emptyModifiers => {
        ModifierType.attack: null,
        ModifierType.move: null,
        ModifierType.range: null,
      };
}
