import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'enemies_event.dart';
part 'enemies_state.dart';

class EnemiesBloc extends HydratedBloc<EnemiesEvent, EnemiesState> {
  final EnemiesRepository enemiesRepository;

  EnemiesBloc(this.enemiesRepository) : super(EnemiesInitialS()) {
    on<StackAddedE>(_onStackAdded);
    on<StackRemovedE>(_onStackRemoved);
  }

  @override
  EnemiesState? fromJson(Map<String, dynamic> json) {
    return EnemiesLoadedS.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(EnemiesState state) {
    if (state is EnemiesLoadedS)
      return state.toMap();
    else
      return null;
  }

  void _onStackAdded(StackAddedE event, Emitter<EnemiesState> emit) {
    if (state is EnemiesLoadedS) {
      var _state = state as EnemiesLoadedS;
      var updatedEnemies = _state.enemies.update(event.unitStack);
      emit(EnemiesLoadedS(Enemies(monsters: updatedEnemies)));
    } else {
      emit(EnemiesLoadedS(Enemies(monsters: [event.unitStack])));
    }
  }

  void _onStackRemoved(StackRemovedE event, Emitter<EnemiesState> emit) {
    if (state is EnemiesLoadedS) {
      var _state = state as EnemiesLoadedS;
      var updatedEnemies = [..._state.enemies.monsters]
        ..removeWhere((element) => element.type == event.unitStack.type);
      print(updatedEnemies == _state.enemies.monsters);
      emit(EnemiesLoadedS(Enemies(monsters: updatedEnemies)));
    }
  }
}
