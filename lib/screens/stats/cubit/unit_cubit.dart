import 'package:bloc/bloc.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

class UnitCubit extends Cubit<UnitState> {
  /// Map of negative and positive effects. E.g stun, curse, heal, etc.
  /// Is being used to render a proper icons from [ImageService]
  static final EffectMap effectIcons =
      di<ImageService>().getAttackEffect(IconSize.s64);
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

  /// Get a list of negative effects activated on a unit
  Set<Effect> get negativeEffects {
    return Set.from(
      state.unit.negativeEffects.map((e) => Effect(e, effectIcons[e]!)),
    );
  }

  /// Return List of immune [Effect]
  /// This list is rendered in 'Immune to' section of [UnitStatsCard]
  List<Effect?> get immuneEffects {
    return unit.immune.map((e) => Effect(e, effectIcons[e]!)).toList();
  }
}
