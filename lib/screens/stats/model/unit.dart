import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/mixins/action_type_serializer_mixin.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/common/enums/activity_type.dart';
import 'package:gh_battle_assistant/common/enums/modifier_type.dart';
import 'package:gh_battle_assistant/common/enums/unit_normality.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'unit.g.dart';

@JsonSerializable()
@immutable
class Unit extends Equatable with ActionTypeSerializer {
  final int number;
  final String displayName;
  final bool flying;
  final int healthPoint;
  late final int maxHealthPoint;
  final int shield;
  final int? attack;
  final int? range;
  final int? move;
  final int retaliate;
  late final int retaliateRange;
  final int heal;
  final int suffer;
  final int pierced;
  @JsonKey(defaultValue: const <ActivityType>[])
  final List<ActivityType> perks;
  @JsonKey(defaultValue: const <ActivityType, String>{})
  final Map<ActivityType, String> perkValue;
  @JsonKey(defaultValue: const <ActivityType>[])
  final List<ActivityType> immune;
  @JsonKey(defaultValue: const <String>[])
  final List<String> area;
  @JsonKey(defaultValue: const <ActivityType>{})
  final Set<ActivityType> negativeEffects;
  final bool elite;
  final bool turnEnded;

  Unit({
    required this.number,
    required this.displayName,
    required this.healthPoint,
    this.flying = false,
    maxHealthPoint,
    this.shield = 0,
    this.attack = 0,
    this.range = 0,
    this.move = 0,
    this.retaliate = 0,
    retaliateRange,
    this.heal = 0,
    this.suffer = 0,
    this.pierced = 0,
    this.elite = false,
    this.turnEnded = false,
    this.perks = const [],
    this.perkValue = const {},
    this.immune = const [],
    this.area = const [],
    this.negativeEffects = const {},
  })  : maxHealthPoint = maxHealthPoint ?? healthPoint,
        retaliateRange = (retaliate > 0) ? (retaliateRange ?? 1) : 0;

  factory Unit.fromRawData(
      String name, int health, UnitRawStats data, int number,
      [bool elite = false, bool? flying = false]) {
    var sPerks, sImmune, sPerkValue;
    try {
      sPerks = ActionTypeSerializer.serializeRawData(data.perks);
      sImmune = ActionTypeSerializer.serializeRawData(data.immune);
      sPerkValue = ActionTypeSerializer.serializeRawPerkValue(data.perkValue);
    } catch (e) {
      di<LoggerService>().log(e.toString());
    }

    return Unit(
      displayName: name,
      flying: flying ?? false,
      healthPoint: health,
      maxHealthPoint: health,
      number: number,
      shield: data.shield,
      attack: data.attack,
      range: data.range,
      move: data.move,
      retaliate: data.retaliate,
      retaliateRange: data.retaliateRange,
      elite: elite,
      perks: sPerks ?? const [],
      perkValue: sPerkValue ?? const {},
      immune: sImmune ?? const [],
    );
  }

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  Unit copyWith({
    int? number,
    String? displayName,
    bool? flying,
    int? healthPoint,
    int? maxHealthPoint,
    int? shield,
    int? attack,
    int? range,
    int? move,
    int? retaliate,
    int? retaliateRange,
    int? heal,
    int? suffer,
    int? pierced,
    bool? elite,
    bool? turnEnded,
    List<ActivityType>? perks,
    Map<ActivityType, String>? perkValue,
    List<ActivityType>? immune,
    List<String>? area,
    Set<ActivityType>? negativeEffects,
  }) {
    return Unit(
      number: number ?? this.number,
      displayName: displayName ?? this.displayName,
      flying: flying ?? this.flying,
      healthPoint: healthPoint ?? this.healthPoint,
      maxHealthPoint: maxHealthPoint ?? this.maxHealthPoint,
      shield: shield ?? this.shield,
      attack: attack ?? this.attack,
      range: range ?? this.range,
      move: move ?? this.move,
      retaliate: retaliate ?? this.retaliate,
      retaliateRange: retaliateRange ?? this.retaliateRange,
      heal: heal ?? this.heal,
      suffer: suffer ?? this.suffer,
      pierced: pierced ?? this.pierced,
      elite: elite ?? this.elite,
      negativeEffects: negativeEffects ?? this.negativeEffects,
      perks: perks ?? this.perks,
      perkValue: perkValue ?? this.perkValue,
      immune: immune ?? this.immune,
      area: area ?? this.area,
    );
  }

  String toString() => 'Unit$number: $displayName';

  /// Check if unit has Pierce [ActivityType]
  bool get isPierced => pierced > 0;

  /// Apply negative effects consequences,
  /// remove effects from the set and return updated [Unit]
  Unit applyOldActionEffects() {
    if (turnEnded) return this;

    var updatedEffects = _removeNegativeEffect(negativeEffects, {
      ActivityType.disarm,
      ActivityType.muddle,
      ActivityType.pierce,
      ActivityType.strengthen,
      ActivityType.stun,
      ActivityType.invisible,
      ActivityType.immobilize,
    });

    var updated = _applySuffer()
        ._healedFromAction()
        .copyWith(negativeEffects: updatedEffects, pierced: 0);

    return updated;
  }

  Unit refreshStatsToDefault(StatsByUnitNormalityMap stats) {
    final normality = elite ? UnitNormality.elite : UnitNormality.normal;

    return copyWith(
      attack: stats[normality]?.attack,
      range: stats[normality]?.range ?? 0,
      move: stats[normality]?.move,
      shield: stats[normality]?.shield,
      retaliate: stats[normality]?.retaliate,
      perks:
          ActionTypeSerializer.serializeRawData(stats[normality]?.perks) ?? [],
      area: [],
    );
  }

  Unit applyAction(
      Map<ModifierType, int> modifiers,
      List<ActivityType> newPerks,
      List<String> newArea,
      Map<ActivityType, String> newPerkValue) {
    return copyWith(
      attack: _applyMandatoryModifier(modifiers[ModifierType.attack], attack),
      move: _applyMandatoryModifier(modifiers[ModifierType.move], move),
      // range: _applyMandatoryModifier(modifiers[ModifierType.range], range),
      range: _modifyRange(modifiers[ModifierType.range], range),
      shield: modifiers.containsKey(ModifierType.shield)
          ? modifiers[ModifierType.shield]! + shield
          : shield,
      retaliate: modifiers.containsKey(ModifierType.retaliate)
          ? modifiers[ModifierType.retaliate]! + retaliate
          : retaliate,
      suffer: modifiers[ModifierType.suffer],
      heal: modifiers[ModifierType.heal],
      perks: perks + newPerks,
      perkValue: {...perkValue, ...newPerkValue},
      area: area + newArea,
      healthPoint:
          hasEffect(ActivityType.wound) ? (healthPoint - 1) : healthPoint,
    );
  }

  /// Apply the amount of damage from the user action via [ActivitySelector]
  Unit applyDamage(int value) {
    if (shield > 0) {
      if (pierced > shield) {
        return copyWith(healthPoint: _changeHealth(value), pierced: 0);
      } else {
        var brokenShield = shield - pierced;
        var pureDamage = value - brokenShield;
        return copyWith(healthPoint: _changeHealth(pureDamage), pierced: 0);
      }
    } else {
      return copyWith(healthPoint: _changeHealth(value), pierced: 0);
    }
  }

  /// Apply the amount of heal from the user action via [ActivitySelector]
  Unit applyHeal(int value) {
    // poisoned unit health does not change on heal
    if (hasEffect(ActivityType.poison)) {
      value = 0;
    }

    return copyWith(
      negativeEffects: _removeNegativeEffect(
          negativeEffects, {ActivityType.poison, ActivityType.wound}),
      healthPoint: _changeHealth(-value),
    );
  }

  /// Apply the amount of pure damage (ignoring shield) from the user action via [ActivitySelector]
  Unit applySuffer(int value) {
    return copyWith(
      healthPoint: _changeHealth(value),
    );
  }

  /// Apply the amount of damage to the shield from the user action via [ActivitySelector]
  Unit applyPierce(int value) {
    return copyWith(
      pierced: _positiveSubtraction(pierced, -value),
    );
  }

  /// Add the value to the shield parameter from the user action via [ActivitySelector]
  Unit applyShield(int value) {
    return copyWith(shield: shield + value);
  }

  /// Toggle poison effect from the user action via [ActivitySelector]
  Unit addPoison(bool status) =>
      _toggleNegativeEffect(ActivityType.poison, status);

  /// Toggle wound effect from the user action via [ActivitySelector]
  Unit addWound(bool status) =>
      _toggleNegativeEffect(ActivityType.wound, status);

  /// Toggle disarm effect from the user action via [ActivitySelector]
  Unit addDisarm(bool status) =>
      _toggleNegativeEffect(ActivityType.disarm, status);

  /// Toggle stun effect from the user action via [ActivitySelector]
  Unit addStun(bool status) => _toggleNegativeEffect(ActivityType.stun, status);

  /// Toggle muddle effect from the user action via [ActivitySelector]
  Unit addMuddle(bool status) =>
      _toggleNegativeEffect(ActivityType.muddle, status);

  /// Toggle strengthen effect from the user action via [ActivitySelector]
  Unit addStrengthen(bool status) =>
      _toggleNegativeEffect(ActivityType.strengthen, status);

  /// Toggle immobilize effect from the user action via [ActivitySelector]
  Unit addImmobilize(bool status) =>
      _toggleNegativeEffect(ActivityType.immobilize, status);

  /// Toggle invisible effect from the user action via [ActivitySelector]
  Unit addInvisible(bool status) =>
      _toggleNegativeEffect(ActivityType.invisible, status);

  /// Check if unit has active negative effect
  bool hasEffect(ActivityType type) => negativeEffects.contains(type) == true;

  // Unit _applyWound() {
  //   if (_hasEffect(ActivityType.wound))
  //     return copyWith(healthPoint: healthPoint - 1);
  //   else
  //     return this;
  // }

  Unit _applySuffer() {
    return copyWith(healthPoint: healthPoint - suffer, suffer: 0);
  }

  /// Apply heal if it was present in [UnitAction] card
  Unit _healedFromAction() {
    if (heal == 0) return this;

    if (hasEffect(ActivityType.poison))
      return copyWith(
        negativeEffects: _removeNegativeEffect(
            negativeEffects, {ActivityType.poison, ActivityType.wound}),
        heal: 0,
      );
    else {
      var updatedHealth = healthPoint + heal;
      return copyWith(
        healthPoint:
            updatedHealth > maxHealthPoint ? maxHealthPoint : updatedHealth,
        heal: 0,
        negativeEffects:
            _removeNegativeEffect(negativeEffects, {ActivityType.wound}),
      );
    }
  }

  static Set<ActivityType> _addNegativeEffect(
      Set<ActivityType> original, Set<ActivityType> toAdd) {
    return original.union(toAdd);
  }

  static Set<ActivityType> _removeNegativeEffect(
      Set<ActivityType> original, Set<ActivityType> toRemove) {
    return original.difference(toRemove);
  }

  /// Make special calculation for mandatory stats such as attack and move,
  /// If one of mentioned stats is null then it means that the whole related action
  /// will be skipped for the turn
  ///
  /// Ex. if unit has attack = 3 but action card does not have attack modifier,
  /// than attack will be null this round
  int? _applyMandatoryModifier(int? newValue, int? prevValue) {
    if (newValue == null) return 0;
    if (prevValue != null)
      return prevValue + newValue;
    else
      return newValue;
  }

  /// Range behaves almost the same as mandatory stats (attack or move),
  /// with only one difference - if unit has default range other than null
  /// then it means it's all attacks are ranged even if action does not say it
  int? _modifyRange(int? newValue, int? prevValue) {
    if (newValue == null) return prevValue;
    if (prevValue != null)
      return prevValue + newValue;
    else
      return newValue;
  }

  /// Health points can not be bigger than the maximum value
  /// This method validate this rule
  int _changeHealth(int value) {
    final newValue = _positiveSubtraction(healthPoint, value);
    return newValue > maxHealthPoint ? maxHealthPoint : newValue;
  }

  int _positiveSubtraction(int a, int b) => a - b < 0 ? 0 : a - b;

  Unit _toggleNegativeEffect(ActivityType type, bool status) {
    return copyWith(
      negativeEffects: status
          ? _addNegativeEffect(negativeEffects, {type})
          : _removeNegativeEffect(negativeEffects, {type}),
    );
  }

  @override
  List<Object?> get props => [
        number,
        elite,
        displayName,
        healthPoint,
        shield,
        attack,
        range,
        move,
        retaliate,
        heal,
        suffer,
        pierced,
        perks,
        immune,
        area,
        negativeEffects,
        turnEnded,
      ];
}
