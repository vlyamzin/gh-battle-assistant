import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/mixins/action_type_serializer_mixin.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
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
  final bool? flying;
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
      [bool elite = false, bool flying = false]) {
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
      flying: flying,
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
          _hasEffect(ActivityType.wound) ? (healthPoint - 1) : healthPoint,
    );
  }

  // Unit _applyWound() {
  //   if (_hasEffect(ActivityType.wound))
  //     return copyWith(healthPoint: healthPoint - 1);
  //   else
  //     return this;
  // }

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
