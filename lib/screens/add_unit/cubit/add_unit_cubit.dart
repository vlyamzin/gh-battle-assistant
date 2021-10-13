import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';

part 'add_unit_state.dart';

class AddUnitCubit extends Cubit<AddUnitState> {
  final EnemiesRepository _repository;
  final EnemiesBloc _enemiesBloc;
  final SettingsBloc _settingsBloc;
  late final int difficulty;

  AddUnitCubit(
    this._repository,
    this._enemiesBloc,
    this._settingsBloc,
  ) : super(AddUnitInitial()) {
    if (_settingsBloc.state is SettingsUpdatedS) {
      this.difficulty =
          (_settingsBloc.state as SettingsUpdatedS).settings.difficulty;
    } else {
      this.difficulty = 1;
    }
  }

  Map<UnitType, String> getSuggestion(String query) {
    var searchModel = UnitSearch(_repository.data);
    return searchModel.getSuggestions(query);
  }

  void selectUnitType(String name) {
    UnitStack? existingStack;
    UnitStack newStack;

    var data = _repository.byName(name);

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

    emit(UnitTypeSelectedS(newStack));
  }

  void selectUnit(int number) {
    if (state is UnitTypeSelectedS) {
      var _state = state as UnitTypeSelectedS;
      var selectionType = _toggleSelectionType(_state, number);

      if (selectionType == UnitSelectionType.none) {
        var updatedStack = _state.stack.removeUnitImmutable(number);
        print(updatedStack == _state.stack);
        emit(UnitTypeSelectedS(updatedStack));
      } else {
        var data = _repository.byId(UnitType.ancientArtillery);
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
          updatedStack = _state.stack.updateUnitImmutable(unit);
        else
          updatedStack = _state.stack.addUnitImmutable(unit);

        emit(UnitTypeSelectedS(updatedStack));
      }
    }
  }

  void saveSelection() {
    if (state is UnitTypeSelectedS) {
      var _state = state as UnitTypeSelectedS;
      var numbersInUse = _state.stack.units.map((unit) => unit.number).toList();
      var updatedStack = _state.stack.copyWith(
          availableNumbersPull: _state.stack.availableNumbersPull
              .where((number) => !numbersInUse.contains(number))
              .toList());

      if (updatedStack.units.isNotEmpty) {
        _enemiesBloc.add(StackAddedE(updatedStack));
      }

      emit(UnitAddedS());
    }
  }

  UnitSelectionType _toggleSelectionType(UnitTypeSelectedS state, int number) {
    try {
      var unit = state.stack.getUnitByNumber(number);

      if (unit.elite)
        return UnitSelectionType.none;
      else
        return UnitSelectionType.elite;
    } catch (_) {
      return UnitSelectionType.normal;
    }
  }
}
