import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'enemies_event.dart';

class EnemiesBloc extends HydratedBloc<EnemiesEvent, EnemiesState> {
  final EnemiesRepository enemiesRepository;

  EnemiesBloc(this.enemiesRepository) : super(EnemiesState.initial()) {
    on<StackAddedE>(_onStackAdded);
    on<StackRemovedE>(_onStackRemoved);
    on<ClearEnemiesList>(_onClearEnemies);
  }

  @override
  EnemiesState? fromJson(Map<String, dynamic> json) {
    return EnemiesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(EnemiesState state) {
    return state.toJson();
  }

  void _onStackAdded(StackAddedE event, Emitter<EnemiesState> emit) {
    state.maybeMap(loaded: (EnemiesLoaded state) {
      var updatedEnemies = state.enemies.update(event.unitStack);
      emit(EnemiesState.loaded(Enemies(monsters: updatedEnemies)));
    }, orElse: () {
      emit(EnemiesState.loaded(Enemies(monsters: [event.unitStack])));
    });
  }

  void _onStackRemoved(StackRemovedE event, Emitter<EnemiesState> emit) {
    state.maybeMap(
        loaded: (EnemiesLoaded state) {
          var updatedEnemies = [...state.enemies.monsters]
            ..removeWhere((element) => element.type == event.unitStack.type);
          emit(EnemiesState.loaded(Enemies(monsters: updatedEnemies)));
        },
        orElse: () {});
  }

  void _onClearEnemies(_, Emitter<EnemiesState> emit) {
    emit(EnemiesState.loaded(Enemies(monsters: [])));
  }
}
