import 'package:bloc/bloc.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

class UnitCubit extends Cubit<UnitState> {
  /// Map of negative and positive effects. E.g stun, curse, heal, etc.
  /// Is being used to render a proper icons from [ImageService]
  static final EffectMap effectIcons =
      di<ImageService>().getAttackEffect(IconSize.s64);

  /// Selecting of these [ActivityType]s makes no sense
  /// They will not affect unit stats anyhow
  static final List<ActivityType> nonSelectableActivityTypes = [
    ActivityType.bless,
    ActivityType.curse,
    ActivityType.pull,
    ActivityType.push,
    ActivityType.target,
    ActivityType.advantage,
    ActivityType.disadvantage
  ];
  final Unit unit;
  final Function(Unit unit) onStateChanged;
  final Function(int number) onUnitRemoved;
  late final List<Effect> activityEffects = _initActivityTypes();

  UnitCubit(
      {required this.unit,
      required this.onStateChanged,
      required this.onUnitRemoved})
      : super(UnitState.ready(unit));

  void minusActivity() {
    state.when(
      ready: (unit, _) {
        var updatedUnit = unit.copyWith(healthPoint: unit.healthPoint - 1);
        updatedUnit.healthPoint == 0
            ? onUnitRemoved(unit.number)
            : onStateChanged(updatedUnit);
        emit(UnitState.ready(updatedUnit, _));
      },
    );
  }

  void plusActivity() {
    state.when(
      ready: (unit, _) {
        var updatedUnit = unit.copyWith(healthPoint: unit.healthPoint + 1);
        emit(UnitState.ready(updatedUnit, _));
        onStateChanged(updatedUnit);
      },
    );
  }

  void selectActivityType(Effect newActivity) {
    state.when(ready: (unit, selectedActivity) {
      if (selectedActivity != newActivity) {
        emit(UnitState.ready(unit, newActivity));
      }
    });
  }

  void applyActivity() {}

  Unit get unitInstance => state.unit;

  /// Return [Effect] from state or first item from [activityEffects] list
  Effect get selectedActivity => state.selectedActivity ?? activityEffects[0];

  /// Get a list of negative effects activated on a unit
  Set<Effect> get negativeEffects {
    return Set.from(
      state.unit.negativeEffects.map((e) => Effect(e, effectIcons[e]!)),
    );
  }

  /// Return List of immune [Effect]
  /// This list is rendered in 'Immune to' section of [UnitStatsCard]
  List<Effect?> get immuneEffects {
    return state.unit.immune.map((e) => Effect(e, effectIcons[e]!)).toList();
  }

  /// Return List of attack [Effect] aka perks
  /// This list is rendered in 'Attack effects' section of [UnitStatsCard]
  List<Effect?> get attackEffects {
    return state.unit.perks.map((p) {
      var perkValue =
          state.unit.perkValue.containsKey(p) ? state.unit.perkValue[p] : null;
      return Effect(p, effectIcons[p]!, perkValue);
    }).toList();
  }

  /// Return List of area images as path to assets
  List<String> get areaEffects {
    return state.unit.area.map((i) => di<ImageService>().getIcon(i)).toList();
  }

  /// Return available activity types such as 'attack', 'heal', 'stun', etc
  /// that user can select from [ActivitySelector] and apply to unit
  /// This list depends on [Unit.immune] values
  List<Effect> _initActivityTypes() {
    var list = <Effect>[];
    var index = 0;
    effectIcons.forEach((key, value) {
      final typesToExclude = state.unit.immune + nonSelectableActivityTypes;
      if (!typesToExclude.contains(key)) {
        list.add(Effect(key, value, null, index));
        index++;
      }
    });
    return list;
  }
}
