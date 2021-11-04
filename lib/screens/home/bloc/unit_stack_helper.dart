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
      var newUnit = unit
          .applyOldActionEffects()
          .refreshStatsToDefault(stats)
          .applyAction(
              action.modifiers, action.perks, action.area, action.perkValue);
      return newUnit;
    }).toList();

    return stack.copyWith(units: updatedUnits.toList());
  }
}
