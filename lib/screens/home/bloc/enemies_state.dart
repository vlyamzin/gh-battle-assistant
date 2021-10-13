part of 'enemies_bloc.dart';

@immutable
abstract class EnemiesState extends Equatable {
  const EnemiesState();

  @override
  List<Object> get props => [];
}

class EnemiesInitialS extends EnemiesState {}

class EnemiesLoadedS extends EnemiesState {
  final Enemies enemies;

  const EnemiesLoadedS(this.enemies);

  factory EnemiesLoadedS.fromMap(Map<String, dynamic> entity) {
    return EnemiesLoadedS(Enemies.fromJson(entity['enemies']));
  }

  Map<String, dynamic> toMap() {
    return {'enemies': enemies.toJson()};
  }

  @override
  List<Object> get props => [enemies];
}

class GameStartedS extends EnemiesState {
  final Enemies enemies;

  const GameStartedS(this.enemies);

  @override
  List<Object> get props => [enemies];
}

class EnemiesLoadingErrorS extends EnemiesState {}
