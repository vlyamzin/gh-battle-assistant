// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) {
  return Unit(
    number: json['number'] as int?,
    displayName: json['displayName'] as String,
    healthPoint: json['healthPoint'] as int,
    shield: json['shield'] as int?,
    attack: json['attack'] as int?,
    range: json['range'] as int?,
    move: json['move'] as int?,
    retaliate: json['retaliate'] as int?,
    suffer: json['suffer'] as int,
    elite: json['elite'] as bool,
    turnEnded: json['turnEnded'] as bool,
    perks: (json['perks'] as List<dynamic>?)
            ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
            .toList() ??
        [],
    immune: (json['immune'] as List<dynamic>?)
            ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
            .toList() ??
        [],
    negativeEffects: (json['negativeEffects'] as List<dynamic>?)
            ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
            .toSet() ??
        {},
  );
}

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'healthPoint': instance.healthPoint,
      'shield': instance.shield,
      'attack': instance.attack,
      'range': instance.range,
      'move': instance.move,
      'retaliate': instance.retaliate,
      'suffer': instance.suffer,
      'perks': instance.perks?.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'immune': instance.immune?.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'negativeEffects': instance.negativeEffects
          ?.map((e) => _$ActivityTypeEnumMap[e])
          .toList(),
      'elite': instance.elite,
      'turnEnded': instance.turnEnded,
      'number': instance.number,
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
  ActivityType.none: 'none',
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
  ActivityType.target_2: 'target_2',
  ActivityType.target_3: 'target_3',
  ActivityType.target_4: 'target_4',
  ActivityType.target_all: 'target_all',
  ActivityType.invisible: 'invisible',
};
