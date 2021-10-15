// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      number: json['number'] as int,
      displayName: json['displayName'] as String,
      healthPoint: json['healthPoint'] as int,
      shield: json['shield'] as int? ?? 0,
      attack: json['attack'] as int? ?? 0,
      range: json['range'] as int? ?? 0,
      move: json['move'] as int? ?? 0,
      retaliate: json['retaliate'] as int? ?? 0,
      heal: json['heal'] as int? ?? 0,
      suffer: json['suffer'] as int? ?? 0,
      pierced: json['pierced'] as int? ?? 0,
      elite: json['elite'] as bool? ?? false,
      turnEnded: json['turnEnded'] as bool? ?? false,
      perks: (json['perks'] as List<dynamic>?)
              ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
              .toList() ??
          [],
      immune: (json['immune'] as List<dynamic>?)
              ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
              .toList() ??
          [],
      area:
          (json['area'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      negativeEffects: (json['negativeEffects'] as List<dynamic>?)
              ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
              .toSet() ??
          {},
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'number': instance.number,
      'displayName': instance.displayName,
      'healthPoint': instance.healthPoint,
      'shield': instance.shield,
      'attack': instance.attack,
      'range': instance.range,
      'move': instance.move,
      'retaliate': instance.retaliate,
      'heal': instance.heal,
      'suffer': instance.suffer,
      'pierced': instance.pierced,
      'perks': instance.perks?.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'immune': instance.immune?.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'area': instance.area,
      'negativeEffects': instance.negativeEffects
          ?.map((e) => _$ActivityTypeEnumMap[e])
          .toList(),
      'elite': instance.elite,
      'turnEnded': instance.turnEnded,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

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
  ActivityType.target_2: 'target_2',
  ActivityType.target_3: 'target_3',
  ActivityType.target_4: 'target_4',
  ActivityType.target_all: 'target_all',
  ActivityType.invisible: 'invisible',
};
