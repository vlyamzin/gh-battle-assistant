import 'package:bloc/bloc.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class UnitCubit extends Cubit<UnitState> {
  final Unit unit;
  final Function onStateChanged;

  UnitCubit({
    required this.unit,
    required this.onStateChanged,
  }) : super(UnitState.ready(unit));

  void minusActivity() {
    state.when(ready: (unit) {
      var updatedUnit = unit.copyWith(healthPoint: unit.healthPoint - 1);
      emit(UnitState.ready(updatedUnit));
      onStateChanged(updatedUnit);
    });
  }

  void plusActivity() {
    state.when(ready: (unit) {
      var updatedUnit = unit.copyWith(healthPoint: unit.healthPoint + 1);
      emit(UnitState.ready(updatedUnit));
      onStateChanged(updatedUnit);
    });
  }

  void applyActivity() {}
}
