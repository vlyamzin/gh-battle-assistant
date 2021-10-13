part of 'add_unit_cubit.dart';

abstract class AddUnitState extends Equatable {
  const AddUnitState();

  @override
  List<Object> get props => [];
}

class AddUnitInitial extends AddUnitState {}

class FilteredUnitsS extends AddUnitState {
  final UnitSearch matches;

  const FilteredUnitsS(this.matches);

  @override
  List<Object> get props => [matches];
}

class UnitTypeSelectedS extends AddUnitState {
  final UnitStack stack;

  const UnitTypeSelectedS(this.stack);

  @override
  List<Object> get props => [stack, stack.units];
}

class UnitAddedS extends AddUnitState {}
