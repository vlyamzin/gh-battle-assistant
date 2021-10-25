import 'package:bloc/bloc.dart';

import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';

import '../../../di.dart';

class AddUnitCubit extends Cubit<AddUnitState> {
  final EnemiesRepository _repository;
  final EnemiesBloc _enemiesBloc;
  late final int difficulty;

  AddUnitCubit(
    this._repository,
    this._enemiesBloc,
  ) : super(AddUnitState.initial()) {
    try {
      this.difficulty = di<SettingsRepository>().loadSettings().difficulty;
    } catch (e) {
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

    _enemiesBloc.state.maybeWhen(
      initial: () {
        newStack = UnitStack.fromRawData(data);
        emit(AddUnitState.selectedUnitType(newStack));
      },
      loaded: (Enemies enemies) {
        existingStack = enemies.getByType(data.id);

        if (existingStack != null) {
          newStack = existingStack!.copyWith();
        } else {
          newStack = UnitStack.fromRawData(data);
        }

        emit(AddUnitState.selectedUnitType(newStack));
      },
      orElse: () => di<LoggerService>().log(
          'selectUnitType - Unhandled state ${_enemiesBloc.state.runtimeType}',
          this.runtimeType),
    );
  }

  void selectUnit(int number) {
    state.maybeMap(
        selectedUnitType: (UnitTypeSelectedS state) {
          var selectionType = _toggleSelectionType(state.stack, number);

          if (selectionType == UnitSelectionType.none) {
            var updatedStack = state.stack.removeUnit(number);
            emit(state.copyWith(stack: updatedStack));
          } else {
            var data = _repository.byId(state.stack.type);
            var unitStats = data.getUnitStatsByNormality(
              selectionType == UnitSelectionType.normal
                  ? UnitNormality.normal
                  : UnitNormality.elite,
              difficulty.toString(),
            );
            var unit = Unit.fromRawData(
              data.name,
              unitStats!.health,
              unitStats,
              number,
              selectionType == UnitSelectionType.elite,
            );
            var updatedStack;
            if (selectionType == UnitSelectionType.elite)
              updatedStack = state.stack.updateUnit(unit);
            else
              updatedStack = state.stack.addUnit(unit);

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
