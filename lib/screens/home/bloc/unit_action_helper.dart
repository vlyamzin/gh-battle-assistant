part of 'enemies_bloc.dart';

class UnitActionHelper {
  EnemiesRepository _enemiesRepository;

  UnitActionHelper(this._enemiesRepository);

  UnitActionList initActions(UnitStack stack) {
    var rawData = _enemiesRepository.byId(stack.type);
    var updatedActions = setupActionList(rawData.actions, stack.actions);
    return initAvailableIndexes(updatedActions);
  }

  UnitActionList refreshAction(UnitActionList actions) {
    UnitActionList? updatedActions;

    if (actions.currentAction != null &&
        actions.currentAction!.shouldRefresh == true) {
      updatedActions = initAvailableIndexes(actions);
      updatedActions.availableActionIndexes?.shuffle();
    }
    return setAction(updatedActions ?? actions);
  }

  UnitActionList setAction(UnitActionList actions) {
    assert(actions.availableActionIndexes != null);
    assert(actions.allActions != null);

    if (actions.availableActionIndexes != null && actions.allActions != null) {
      final rnd =
          di<UtilService>().randomize(actions.availableActionIndexes!.length);
      final index = actions.availableActionIndexes![rnd];
      var updatedIndexes =
          actions.availableActionIndexes!.where((i) => i != index);
      var curAction = actions.allActions![index];

      return actions.copyWith(
          currentAction: curAction,
          availableActionIndexes: updatedIndexes.toList());
    } else {
      di<LoggerService>().log(
          'New action generation has failed. AvailableIndexes of allActions are null',
          this.runtimeType);
      return actions;
    }
  }

  UnitActionList setupActionList(List<UnitRawAction> rawData,
      [UnitActionList? actions]) {
    final newActions = rawData.map((e) => UnitAction.fromRawData(e)).toList();

    if (actions != null)
      return actions.copyWith(allActions: newActions);
    else
      return UnitActionList(allActions: newActions);
  }

  UnitActionList initAvailableIndexes(UnitActionList actions) {
    assert(actions.allActions != null);

    if (actions.allActions != null) {
      final indexes =
          actions.allActions!.asMap().entries.map((e) => e.key).toList();
      indexes.shuffle();
      return actions.copyWith(availableActionIndexes: indexes);
    } else
      return actions;
  }
}
