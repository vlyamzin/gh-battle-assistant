// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      number: json['number'] as int,
      displayName: json['displayName'] as String,
      healthPoint: json['healthPoint'] as int,
      flying: json['flying'] as bool? ?? false,
      maxHealthPoint: json['maxHealthPoint'],
      shield: json['shield'] as int? ?? 0,
      attack: json['attack'] as int? ?? 0,
      range: json['range'] as int? ?? 0,
      move: json['move'] as int? ?? 0,
      retaliate: json['retaliate'] as int? ?? 0,
      retaliateRange: json['retaliateRange'],
      heal: json['heal'] as int? ?? 0,
      suffer: json['suffer'] as int? ?? 0,
      pierced: json['pierced'] as int? ?? 0,
      elite: json['elite'] as bool? ?? false,
      turnEnded: json['turnEnded'] as bool? ?? false,
      perks: (json['perks'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ActivityTypeEnumMap, e))
              .toList() ??
          [],
      perkValue: (json['perkValue'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry($enumDecode(_$ActivityTypeEnumMap, k), e as String),
          ) ??
          {},
      immune: (json['immune'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ActivityTypeEnumMap, e))
              .toList() ??
          [],
      area:
          (json['area'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      negativeEffects: (json['negativeEffects'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ActivityTypeEnumMap, e))
              .toSet() ??
          {},
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'number': instance.number,
      'displayName': instance.displayName,
      'flying': instance.flying,
      'healthPoint': instance.healthPoint,
      'maxHealthPoint': instance.maxHealthPoint,
      'shield': instance.shield,
      'attack': instance.attack,
      'range': instance.range,
      'move': instance.move,
      'retaliate': instance.retaliate,
      'retaliateRange': instance.retaliateRange,
      'heal': instance.heal,
      'suffer': instance.suffer,
      'pierced': instance.pierced,
      'perks': instance.perks.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'perkValue': instance.perkValue
          .map((k, e) => MapEntry(_$ActivityTypeEnumMap[k], e)),
      'immune': instance.immune.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'area': instance.area,
      'negativeEffects': instance.negativeEffects
          .map((e) => _$ActivityTypeEnumMap[e])
          .toList(),
      'elite': instance.elite,
      'turnEnded': instance.turnEnded,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.attack: 'attack',
  ActivityType.heal: 'heal',
  ActivityType.suffer: 'suffer',
  ActivityType.pierce: 'pierce',
  ActivityType.poison: 'poison',
  ActivityType.wound: 'wound',
  ActivityType.disarm: 'disarm',
  ActivityType.stun: 'stun',
  ActivityType.immobilize: 'immobilize',
  ActivityType.muddle: 'muddle',
  ActivityType.curse: 'curse',
  ActivityType.bless: 'bless',
  ActivityType.strengthen: 'strengthen',
  ActivityType.pull: 'pull',
  ActivityType.push: 'push',
  ActivityType.target: 'target',
  ActivityType.invisible: 'invisible',
  ActivityType.advantage: 'advantage',
  ActivityType.disadvantage: 'disadvantage',
  ActivityType.shield: 'shield',
};
