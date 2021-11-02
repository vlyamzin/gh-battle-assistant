import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'unit.g.dart';

@JsonSerializable()
@immutable
class Unit extends Equatable {
  final int number;
  final String displayName;
  final int healthPoint;
  late final int maxHealthPoint;
  final int shield;
  final int? attack;
  final int? range;
  final int? move;
  final int retaliate;
  final int heal;
  final int suffer;
  final int pierced;
  @JsonKey(defaultValue: <ActivityType>[])
  final List<ActivityType> perks;
  @JsonKey(defaultValue: <ActivityType>[])
  final List<ActivityType> immune;
  @JsonKey(defaultValue: <String>[])
  final List<String> area;
  @JsonKey(defaultValue: <ActivityType>{})
  final Set<ActivityType> negativeEffects;
  final bool elite;
  final bool turnEnded;

  Unit({
    required this.number,
    required this.displayName,
    required this.healthPoint,
    maxHealthPoint,
    this.shield = 0,
    this.attack = 0,
    this.range = 0,
    this.move = 0,
    this.retaliate = 0,
    this.heal = 0,
    this.suffer = 0,
    this.pierced = 0,
    this.elite = false,
    this.turnEnded = false,
    this.perks = const [],
    this.immune = const [],
    this.area = const [],
    this.negativeEffects = const {},
  }) : maxHealthPoint = maxHealthPoint ?? healthPoint;

  factory Unit.fromRawData(
      String name, int health, UnitRawStats data, int number,
      [bool elite = false]) {
    var sPerks = serializeRawData(data.perks);
    var sImmune = serializeRawData(data.immune);

    return Unit(
      displayName: name,
      healthPoint: health,
      maxHealthPoint: health,
      number: number,
      shield: data.shield,
      attack: data.attack,
      range: data.range,
      move: data.move,
      retaliate: data.retaliate,
      elite: elite,
      perks: sPerks ?? [],
      immune: sImmune ?? [],
    );
  }

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  Unit copyWith({
    int? number,
    String? displayName,
    int? healthPoint,
    int? maxHealthPoint,
    int? shield,
    int? attack,
    int? range,
    int? move,
    int? retaliate,
    int? heal,
    int? suffer,
    int? pierced,
    bool? elite,
    bool? turnEnded,
    List<ActivityType>? perks,
    List<ActivityType>? immune,
    List<String>? area,
    Set<ActivityType>? negativeEffects,
  }) {
    return Unit(
      number: number ?? this.number,
      displayName: displayName ?? this.displayName,
      healthPoint: healthPoint ?? this.healthPoint,
      maxHealthPoint: maxHealthPoint ?? this.maxHealthPoint,
      shield: shield ?? this.shield,
      attack: attack ?? this.attack,
      range: range ?? this.range,
      move: move ?? this.move,
      retaliate: retaliate ?? this.retaliate,
      heal: heal ?? this.heal,
      suffer: suffer ?? this.suffer,
      pierced: pierced ?? this.pierced,
      elite: elite ?? this.elite,
      negativeEffects: negativeEffects ?? this.negativeEffects,
      perks: perks ?? this.perks,
      immune: immune ?? this.immune,
      area: area ?? this.area,
    );
  }

  String toString() => 'Unit$number: $displayName';

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
        ._applyHeal()
        .copyWith(negativeEffects: updatedEffects, pierced: 0);

    return updated;
  }

  Unit refreshStatsToDefault(StatsByUnitNormalityMap stats) {
    final normality = elite ? UnitNormality.elite : UnitNormality.normal;

    return copyWith(
      attack: stats[normality]?.attack,
      range: stats[normality]?.range,
      move: stats[normality]?.move,
      shield: stats[normality]?.shield,
      retaliate: stats[normality]?.retaliate,
      perks: serializeRawData(stats[normality]?.perks) ?? [],
      area: [],
    );
  }

  Unit applyAction(Map<ModifierType, int> modifiers,
      List<ActivityType> newPerks, List<String> newArea) {
    return copyWith(
      attack: _applyMandatoryModifier(modifiers[ModifierType.attack], attack),
      move: _applyMandatoryModifier(modifiers[ModifierType.move], move),
      range: _applyMandatoryModifier(modifiers[ModifierType.range], range),
      shield: modifiers.containsKey(ModifierType.shield)
          ? modifiers[ModifierType.shield]! + shield
          : shield,
      retaliate: modifiers.containsKey(ModifierType.retaliate)
          ? modifiers[ModifierType.retaliate]! + retaliate
          : retaliate,
      suffer: modifiers[ModifierType.suffer],
      heal: modifiers[ModifierType.heal],
      perks: perks + newPerks,
      area: area + newArea,
    );
  }

  Unit _applyWound() {
    if (_hasEffect(ActivityType.wound))
      return copyWith(healthPoint: healthPoint - 1);
    else
      return this;
  }

  Unit _applySuffer() {
    return copyWith(healthPoint: healthPoint - suffer, suffer: 0);
  }

  Unit _applyHeal() {
    if (heal == 0) return this;

    if (_hasEffect(ActivityType.poison))
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

  Set<ActivityType> _removeNegativeEffect(
      Set<ActivityType> original, Set<ActivityType> toRemove) {
    return original.difference(toRemove);
  }

  bool _hasEffect(ActivityType type) => negativeEffects.contains(type) == true;

  /// Make special calculation for mandatory stats such as attack, move, range
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

  static List<ActivityType>? serializeRawData(List<String>? list) {
    return list?.map((value) {
      switch (value) {
        case 'pierce':
          return ActivityType.pierce;
        case 'poison':
          return ActivityType.poison;
        case 'wound':
          return ActivityType.wound;
        case 'disarm':
          return ActivityType.disarm;
        case 'immobilize':
          return ActivityType.immobilize;
        case 'muddle':
          return ActivityType.muddle;
        case 'curse':
          return ActivityType.curse;
        case 'bless':
          return ActivityType.bless;
        case 'stun':
          return ActivityType.stun;
        case 'invisible':
          return ActivityType.invisible;
        case 'strengthen':
          return ActivityType.strengthen;
        case 'pull':
          return ActivityType.pull;
        case 'push':
          return ActivityType.push;
        case 'target_2':
          return ActivityType.target_2;
        case 'target_3':
          return ActivityType.target_3;
        case 'target_4':
          return ActivityType.target_4;
        case 'target_all':
          return ActivityType.target_all;
        default:
          throw Exception('Serialize raw data exception');
      }
    }).toList();
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
