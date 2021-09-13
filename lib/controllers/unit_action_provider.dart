import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/models/enums/home_screen_events.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:gh_battle_assistant/models/unit_action_list.dart';
import 'package:gh_battle_assistant/services/util_service.dart';

import '../di.dart';

class UnitActionProvider with ChangeNotifier {
  final UnitActionList actions;
  final HomeScreenProvider store;
  final List<UnitRawAction> rawData;
  final UnitStackProvider stackProvider;
  late StreamSubscription _subscription;

  UnitActionProvider({
    required this.actions,
    required this.store,
    required this.rawData,
    required this.stackProvider,
  }) {
    _setAllActions();
    _subscribeToUpdates();

    if (this.actions.currentAction == null) {
      _setAction();
      stackProvider.applyModifiers(this.actions.currentAction!.modifiers);
      _saveChanges();
    }
  }

  void endRound() {
    stackProvider.applyNegativeEffect();
    _refreshActions();
    stackProvider.refreshStatsToDefault();
    stackProvider.applyModifiers(actions.currentAction!.modifiers);
    _saveChanges();
  }

  void _refreshActions() {
    if (actions.currentAction != null &&
        actions.currentAction!.shouldRefresh == true) {
      _initAvailableIndexes();
      actions.availableActionIndexes!.shuffle();
    }

    _setAction();
  }

  void _subscribeToUpdates() {
    _subscription = this.store.event$.listen((event) {
      if (event == HomeScreenEvents.NEW_ACTIONS) {
        endRound();
      }
    });
  }

  void _setAction() {
    final rnd =
        di<UtilService>().randomize(actions.availableActionIndexes!.length);
    final index = actions.availableActionIndexes!.removeAt(rnd);

    actions.currentAction = actions.allActions[index];
  }

  void _setAllActions() {
    actions.allActions = rawData.map((e) => UnitAction.fromRawData(e)).toList();
    if (actions.availableActionIndexes == null) _initAvailableIndexes();
  }

  void _saveChanges() {
    notifyListeners();
    store.saveToStorage();
  }

  void _initAvailableIndexes() {
    actions.availableActionIndexes =
        actions.allActions.asMap().entries.map((e) => e.key).toList();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
