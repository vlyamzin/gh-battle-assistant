part of 'enemies_bloc.dart';

abstract class EnemiesEvent extends Equatable {
  const EnemiesEvent();

  @override
  List<Object> get props => [];
}

class StackAddedE extends EnemiesEvent {
  final UnitStack unitStack;

  const StackAddedE(this.unitStack);

  @override
  List<Object> get props => [unitStack];
}

class StackRemovedE extends EnemiesEvent {
  final UnitStack unitStack;

  const StackRemovedE(this.unitStack);

  @override
  List<Object> get props => [unitStack];
}

class StackUpdatedE extends EnemiesEvent {
  final UnitStack unitStack;

  const StackUpdatedE(this.unitStack);

  @override
  List<Object> get props => [unitStack];
}

class NewActionRequested extends EnemiesEvent {}

class ClearEnemiesList extends EnemiesEvent {}
