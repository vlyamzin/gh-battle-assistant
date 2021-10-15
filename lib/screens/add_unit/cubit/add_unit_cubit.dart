import 'package:bloc/bloc.dart';

import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';

class AddUnitCubit extends Cubit<AddUnitState> {
  final EnemiesRepository _repository;
  final EnemiesBloc _enemiesBloc;
  final SettingsBloc _settingsBloc;
  late final int difficulty;

  AddUnitCubit(
    this._repository,
    this._enemiesBloc,
    this._settingsBloc,
  ) : super(AddUnitState.initial()) {
    _settingsBloc.state.maybeWhen(
        orElse: () => this.difficulty = 1,
        updated: (Settings settings) {
          this.difficulty = settings.difficulty;
        });
  }

  Map<UnitType, String> getSuggestion(String query) {
    var searchModel = UnitSearch(_repository.data);
    return searchModel.getSuggestions(query);
  }

  void selectUnitType(String name) {
    UnitStack? existingStack;
    UnitStack newStack;

    var data = _repository.byName(name);

    // TODO add maybeWhen here
    if (_enemiesBloc.state is EnemiesLoadedS ||
        _enemiesBloc.state is GameStartedS) {
      var enemiesState = _enemiesBloc.state as EnemiesLoadedS;
      existingStack = enemiesState.enemies.getByType(data.id);
    }
    if (existingStack != null) {
      newStack = existingStack.copyWith();
    } else {
      newStack = UnitStack.fromRawData(data);
    }

    emit(AddUnitState.selectedUnitType(newStack));
  }

  void selectUnit(int number) {
    state.maybeMap(
        selectedUnitType: (UnitTypeSelectedS state) {
          var selectionType = _toggleSelectionType(state.stack, number);

          if (selectionType == UnitSelectionType.none) {
            var updatedStack = state.stack.removeUnitImmutable(number);
            emit(state.copyWith(stack: updatedStack));
          } else {
            var data = _repository.byId(state.stack.type);
            var unitStats = data.getUnitStatsByNormality(
              selectionType == UnitSelectionType.normal
                  ? UnitNormality.normal
                  : UnitNormality.elite,
              difficulty.toString(),
            );
            var unit = Unit.fromRawData2(
              data.name,
              unitStats!.health,
              unitStats,
              number,
              selectionType == UnitSelectionType.elite,
            );
            var updatedStack;
            if (selectionType == UnitSelectionType.elite)
              updatedStack = state.stack.updateUnitImmutable(unit);
            else
              updatedStack = state.stack.addUnitImmutable(unit);

            emit(state.copyWith(stack: updatedStack));
          }
        },
        orElse: () {});
  }

  void saveSelection() {
    state.maybeMap(
        selectedUnitType: (UnitTypeSelectedS state) {
          var numbersInUse =
              state.stack.units.map((unit) => unit.number).toList();
          var updatedStack = state.stack.copyWith(
              availableNumbersPull: state.stack.availableNumbersPull
                  .where((number) => !numbersInUse.contains(number))
                  .toList());

          if (updatedStack.units.isNotEmpty) {
            _enemiesBloc.add(StackAddedE(updatedStack));
          }

          emit(AddUnitState.unitAdded());
        },
        orElse: () {});
  }

  UnitSelectionType _toggleSelectionType(UnitStack stack, int number) {
    try {
      var unit = stack.getUnitByNumber(number);

      if (unit.elite)
        return UnitSelectionType.none;
      else
        return UnitSelectionType.elite;
    } catch (_) {
      return UnitSelectionType.normal;
    }
  }
}
