import 'package:bloc/bloc.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/common/enums/activity_type.dart';
import 'package:gh_battle_assistant/screens/stats/model/user_action.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

typedef UserActionHandler = Unit Function(dynamic v, Unit a);

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
  static const _activityHandlers = const <ActivityType, UserActionHandler>{
    ActivityType.attack: _attackU,
    ActivityType.heal: _healU,
    ActivityType.suffer: _sufferDamageU,
    ActivityType.pierce: _pierceU,
    ActivityType.poison: _poisonU,
    ActivityType.wound: _woundU,
    ActivityType.disarm: _disarmU,
    ActivityType.stun: _stunU,
    ActivityType.muddle: _muddleU,
    ActivityType.strengthen: _strengthenU,
    ActivityType.immobilize: _immobilizeU,
    ActivityType.invisible: _invisibleU,
    ActivityType.shield: _shieldU
  };
  final Unit unit;
  final Function(Unit unit) onStateChanged;
  final Function(int number) onUnitRemoved;
  late final List<Effect> activityEffects = _initActivityTypes();

  UnitCubit(
      {required this.unit,
      required this.onStateChanged,
      required this.onUnitRemoved})
      : super(
          UnitState.ready(
            unit,
            UserAction(
              actionType: Effect(ActivityType.attack,
                  effectIcons[ActivityType.attack]!, null, 0),
              value: 1,
            ),
          ),
        );

  void selectActivityType(Effect newActivity) {
    state.when(ready: (unit, userAction) {
      if (userAction.actionType != newActivity) {
        if (isCountableAction(newActivity.type)) {
          var updatedAction = userAction.copyWith(
            actionType: newActivity,
            value: 1,
          );
          emit(UnitState.ready(unit, updatedAction));
        } else {
          // check unit negative effects
          // if effect is present there then UserAction.value must be false
          // otherwise UserAction.value is true
          var defaultValue = unit.hasEffect(newActivity.type) != true;
          var updatedAction =
              userAction.copyWith(actionType: newActivity, value: defaultValue);
          emit(UnitState.ready(unit, updatedAction));
        }
      }
    });
  }

  void selectActivityValue(dynamic value) {
    state.when(ready: (unit, userAction) {
      var updatedUserAction = userAction.copyWith(value: value);
      emit(UnitState.ready(unit, updatedUserAction));
    });
  }

  void applyUserAction() {
    state.when(ready: (unit, userAction) {
      var type = userAction.actionType.type;
      var value = userAction.value;
      var updatedUnit = _activityHandlers[type]!(value, unit);
      emit(UnitState.ready(updatedUnit, userAction));
      updatedUnit.healthPoint == 0
          ? onUnitRemoved(unit.number)
          : onStateChanged(updatedUnit);
    });
  }

  Unit get unitInstance => state.unit;

  static bool isCountableAction(ActivityType type) {
    switch (type) {
      case ActivityType.attack:
      case ActivityType.heal:
      case ActivityType.suffer:
      case ActivityType.pierce:
      case ActivityType.shield:
        {
          return true;
        }
      default:
        {
          return false;
        }
    }
  }

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

  static Unit _attackU(value, Unit unit) => unit.applyDamage(value);

  static Unit _healU(value, Unit unit) => unit.applyHeal(value);

  static Unit _sufferDamageU(value, Unit unit) => unit.applySuffer(value);

  static Unit _pierceU(value, Unit unit) => unit.applyPierce(value);

  static Unit _poisonU(value, Unit unit) => unit.addPoison(value);

  static Unit _woundU(value, Unit unit) => unit.addWound(value);

  static Unit _disarmU(value, Unit unit) => unit.addDisarm(value);

  static Unit _stunU(value, Unit unit) => unit.addStun(value);

  static Unit _muddleU(value, Unit unit) => unit.addMuddle(value);

  static Unit _strengthenU(value, Unit unit) => unit.addStrengthen(value);

  static Unit _immobilizeU(value, Unit unit) => unit.addImmobilize(value);

  static Unit _invisibleU(value, Unit unit) => unit.addInvisible(value);

  static Unit _shieldU(value, Unit unit) => unit.applyShield(value);
}
