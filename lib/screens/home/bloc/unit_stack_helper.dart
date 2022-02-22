part of 'enemies_bloc.dart';

class UnitStackHelper {
  final EnemiesRepository _repository;

  UnitStackHelper(this._repository);

  UnitStack endRound(UnitStack stack, UnitAction? action) {
    var difficulty =
        di<SettingsRepository>().loadSettings().difficulty.toString();
    var stats = _repository.byId(stack.type).getUnitStats(difficulty);

    if (stats == null) throw Exception('No stats available');
    if (action == null) throw Exception('No action available');

    var updatedUnits = stack.units.map((unit) {
      Unit? newUnit;
      // apply turn actions automatically if user does not trigger the by themselves from StatsScreen
      if (stack.turnState == TurnState.idle) {
        newUnit = unit
            .applyAction(
              action.modifiers,
              action.perks,
              action.area,
              action.perkValue,
            )
            .applyOldActionEffects();
      }

      // apply end turn actions automatically if user does not trigger the by themselves from StatsScreen
      if (stack.turnState == TurnState.started) {
        newUnit = (newUnit ?? unit).applyOldActionEffects();
      }

      return (newUnit ?? unit).refreshStatsToDefault(stats);
    }).toList();

    return stack.copyWith(
        units: updatedUnits.toList(), turnState: TurnState.idle);
  }
}
