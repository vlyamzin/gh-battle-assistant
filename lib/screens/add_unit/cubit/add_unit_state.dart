import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';

part 'add_unit_state.freezed.dart';

@freezed
class AddUnitState with _$AddUnitState {
  const factory AddUnitState.initial() = AddUnitInitial;
  const factory AddUnitState.filteredUnits(UnitSearch matches) = FilteredUnitsS;
  const factory AddUnitState.selectedUnitType(UnitStack stack, int unitLevel) =
      UnitTypeSelectedS;
  const factory AddUnitState.unitAdded() = UnitAddedS;
}
