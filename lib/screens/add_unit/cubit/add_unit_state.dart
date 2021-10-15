import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:meta/meta.dart';

part 'add_unit_state.freezed.dart';
// part of 'add_unit_cubit.dart';

@freezed
abstract class AddUnitState with _$AddUnitState {
  const factory AddUnitState.initial() = AddUnitInitial;
  const factory AddUnitState.filteredUnits(UnitSearch matches) = FilteredUnitsS;
  const factory AddUnitState.selectedUnitType(UnitStack stack) =
      UnitTypeSelectedS;
  const factory AddUnitState.unitAdded() = UnitAddedS;
}
// abstract class AddUnitState extends Equatable {
//   const AddUnitState();

//   @override
//   List<Object> get props => [];
// }

// class AddUnitInitial extends AddUnitState {}

// class FilteredUnitsS extends AddUnitState {
//   final UnitSearch matches;

//   const FilteredUnitsS(this.matches);

//   @override
//   List<Object> get props => [matches];
// }

// class UnitTypeSelectedS extends AddUnitState {
//   final UnitStack stack;

//   const UnitTypeSelectedS(this.stack);

//   @override
//   List<Object> get props => [stack, stack.units];
// }

// class UnitAddedS extends AddUnitState {}
