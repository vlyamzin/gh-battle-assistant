import 'package:bloc/bloc.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class UnitCubit extends Cubit<UnitState> {
  final Unit unit;
  final Function(Unit unit) onStateChanged;
  final Function(int number) onUnitRemoved;

  UnitCubit(
      {required this.unit,
      required this.onStateChanged,
      required this.onUnitRemoved})
      : super(UnitState.ready(unit));

  void minusActivity() {
    state.when(
      ready: (unit) {
        var updatedUnit = unit.copyWith(healthPoint: unit.healthPoint - 1);
        updatedUnit.healthPoint == 0
            ? onUnitRemoved(unit.number)
            : onStateChanged(updatedUnit);
        emit(UnitState.ready(updatedUnit));
      },
    );
  }

  void plusActivity() {
    state.when(
      ready: (unit) {
        var updatedUnit = unit.copyWith(healthPoint: unit.healthPoint + 1);
        emit(UnitState.ready(updatedUnit));
        onStateChanged(updatedUnit);
      },
    );
  }

  void applyActivity() {}
}
