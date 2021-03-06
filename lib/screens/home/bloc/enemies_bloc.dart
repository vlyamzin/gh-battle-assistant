import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/common/enums/turn_state.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';
import 'package:gh_battle_assistant/services/util_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'enemies_event.dart';
part 'unit_action_helper.dart';
part 'unit_stack_helper.dart';

class EnemiesBloc extends HydratedBloc<EnemiesEvent, EnemiesState> {
  final EnemiesRepository enemiesRepository;
  late final UnitActionHelper _actionHelper;
  late final UnitStackHelper _stackHelper;

  EnemiesBloc(this.enemiesRepository) : super(EnemiesState.initial()) {
    _actionHelper = UnitActionHelper(enemiesRepository);
    _stackHelper = UnitStackHelper(enemiesRepository);
    on<StackAddedE>(_onStackAdded);
    on<StackRemovedE>(_onStackRemoved);
    on<StackUpdatedE>(_onStackUpdated);
    on<ClearEnemiesList>(_onClearEnemies);
    on<NewActionRequested>(_onNewAction);
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
      UnitStack? updatedStack;
      var isNewStack = state.enemies.getByType(event.unitStack.type) == null;
      var isNewGame = di<SettingsRepository>().loadSettings().newGame;

      // cover the case when new stack must be initialized with the currentAction
      if (!isNewGame && isNewStack) {
        var action = _actionHelper.initActions(event.unitStack);
        action = _actionHelper.refreshAction(action);
        updatedStack = event.unitStack.copyWith(actions: action);
      }

      var updatedEnemies =
          state.enemies.update(updatedStack ?? event.unitStack);

      if (!isNewGame) _sortEnemiesByInitiative(updatedEnemies);
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

  void _onStackUpdated(StackUpdatedE event, Emitter<EnemiesState> emit) {
    state.maybeMap(loaded: (EnemiesLoaded state) {
      var updatedEnemies = state.enemies.update(event.unitStack);
      emit(EnemiesState.loaded(Enemies(monsters: updatedEnemies)));
    }, orElse: () {
      di<LoggerService>()
          .log('onStackUpdated - Unhandled state ${state.runtimeType}');
    });
  }

  void _onClearEnemies(_, Emitter<EnemiesState> emit) {
    emit(EnemiesState.initial());
  }

  void _onNewAction(_, Emitter<EnemiesState> emit) {
    state.maybeWhen(
        loaded: (Enemies enemies) {
          var updatedMonsters = enemies.monsters
              .map((UnitStack stack) {
                UnitActionList? updatedActions;
                UnitStack updatedStack;

                if (di<SettingsRepository>().loadSettings().newGame == true) {
                  updatedActions = _actionHelper.initActions(stack);
                }

                updatedActions = _actionHelper
                    .refreshAction(updatedActions ?? stack.actions);
                try {
                  updatedStack =
                      _stackHelper.endRound(stack, stack.actions.currentAction);
                } catch (e) {
                  di<LoggerService>().log(e.toString(), this.runtimeType);
                  updatedStack = stack;
                }
                return updatedStack.copyWith(actions: updatedActions);
              })
              .where((stack) => stack.units.length > 0)
              .toList();

          _sortEnemiesByInitiative(updatedMonsters);

          emit(
            EnemiesState.loaded(enemies.copyWith(monsters: updatedMonsters)),
          );
        },
        orElse: () => di<LoggerService>().log(
            'selectUnitType - Unhandled state ${state.runtimeType}',
            this.runtimeType));
  }

  void _sortEnemiesByInitiative(List<UnitStack> enemies) {
    enemies.sort((a, b) {
      return a.actions.currentAction!.initiative -
          b.actions.currentAction!.initiative;
    });
  }
}
