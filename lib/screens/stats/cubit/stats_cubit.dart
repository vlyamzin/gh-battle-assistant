import 'package:bloc/bloc.dart';
import 'package:gh_battle_assistant/common/enums/turn_state.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class StatsCubit extends Cubit<StatsState> {
  final EnemiesBloc enemiesBloc;
  final UnitStack stack;

  StatsCubit(this.enemiesBloc, this.stack) : super(StatsState.initial(stack));

  StatsCubit.started(this.enemiesBloc, this.stack)
      : super(StatsState.turnStarted(stack));

  StatsCubit.ended(this.enemiesBloc, this.stack)
      : super(StatsState.turnEnded(stack));

  bool get turnStarted => state is TurnStarted;

  void startTurn() {
    state.when(
      initial: (stack) {
        var action = stack.actions.currentAction;

        if (action != null) {
          var updatedUnits = stack.units.map((unit) {
            return unit.applyAction(
                action.modifiers, action.perks, action.area, action.perkValue);
          }).toList();

          var updatedStack = stack
              .validateDeath(updatedUnits)
              .copyWith(turnState: TurnState.started);

          emit(StatsState.turnStarted(updatedStack));

          // dead by wound
          updatedStack.units.length == 0
              ? enemiesBloc.add(StackRemovedE(updatedStack))
              : enemiesBloc.add(StackUpdatedE(updatedStack));
        }
      },
      turnStarted: (_) {},
      turnEnded: (_) {},
      navigateBack: () {},
    );
  }

  void endTurn() {
    state.when(
      turnStarted: (stack) {
        var updatedUnits = stack.units.map((unit) {
          return unit.applyOldActionEffects().copyWith(turnEnded: true);
        }).toList();

        var updatedStack = stack
            .validateDeath(updatedUnits)
            .copyWith(turnState: TurnState.ended);

        emit(StatsState.turnEnded(updatedStack));

        // dead by suffer from action card
        updatedStack.units.length == 0
            ? enemiesBloc.add(StackRemovedE(updatedStack))
            : enemiesBloc.add(StackUpdatedE(updatedStack));
      },
      initial: (_) {},
      turnEnded: (_) {},
      navigateBack: () {},
    );
  }

  void unitChanged(Unit unit) {
    var handler = (UnitStack stack) {
      var updatedUnits =
          stack.units.map((u) => u.number == unit.number ? unit : u).toList();
      var updatedStack = stack.copyWith(units: updatedUnits);
      enemiesBloc.add(StackUpdatedE(updatedStack));
      return updatedStack;
    };

    state.when(
      initial: (stack) {
        var updatedStack = handler(stack);
        emit(StatsState.initial(updatedStack));
      },
      turnStarted: (stack) {
        var updatedStack = handler(stack);
        emit(StatsState.turnStarted(updatedStack));
      },
      turnEnded: (stack) {
        var updatedStack = handler(stack);
        emit(StatsState.turnEnded(updatedStack));
      },
      navigateBack: () {},
    );
  }

  void unitRemoved(int unitNumber) {
    UnitStack? handler(UnitStack stack) {
      stack.availableNumbersPull.add(unitNumber);
      stack.availableNumbersPull.sort((a, b) => a - b);
      var updatedStack = stack
          .removeUnit(unitNumber)
          .copyWith(availableNumbersPull: stack.availableNumbersPull);

      if (updatedStack.units.length > 0) {
        enemiesBloc.add(StackUpdatedE(updatedStack));
        return updatedStack;
      } else {
        enemiesBloc.add(StackRemovedE(updatedStack));
        emit(StatsState.navigateBack());
        return null;
      }
    }

    state.when(
      initial: (stack) {
        var updatedStack = handler(stack);
        updatedStack != null ? emit(StatsState.initial(updatedStack)) : null;
      },
      turnStarted: (stack) {
        var updatedStack = handler(stack);
        updatedStack != null
            ? emit(StatsState.turnStarted(updatedStack))
            : null;
      },
      turnEnded: (stack) {
        var updatedStack = handler(stack);
        updatedStack != null ? emit(StatsState.turnEnded(updatedStack)) : null;
      },
      navigateBack: () {},
    );
  }
}
