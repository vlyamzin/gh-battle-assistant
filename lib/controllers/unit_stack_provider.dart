import 'dart:async';

import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/enums/home_screen_events.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class UnitStackProvider {
  final UnitStack unitStack;
  final HomeScreenProvider store;
  late StreamSubscription _subscription;

  UnitStackProvider({
    required this.unitStack,
    required this.store,
  }) {
    _subscribeToUpdates();
  }

  void _subscribeToUpdates() {
    _subscription = this.store.event$.listen((event) {
      if (event == HomeScreenEvents.NEW_ACTIONS) {
        _applyModifiers();
      }
    });
  }

  void _applyModifiers() {
    final modifiers = unitStack.actions.currentAction?.modifiers;

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

    store.saveToStorage();
  }

  void dispose() {
    _subscription.cancel();
  }
}
