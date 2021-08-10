// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_raw_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitRawData _$UnitRawDataFromJson(Map<String, dynamic> json) {
  return UnitRawData(
    _$enumDecode(_$UnitTypeEnumMap, json['id']),
    json['name'] as String,
    json['maxNumber'] as int,
    (json['actions'] as List<dynamic>)
        .map((e) => UnitRawAction.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['stats'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(
          k,
          (e as Map<String, dynamic>).map(
            (k, e) => MapEntry(_$enumDecode(_$UnitNormalityEnumMap, k),
                UnitRawStats.fromJson(e as Map<String, dynamic>)),
          )),
    ),
  );
}

Map<String, dynamic> _$UnitRawDataToJson(UnitRawData instance) =>
    <String, dynamic>{
      'id': _$UnitTypeEnumMap[instance.id],
      'name': instance.name,
      'maxNumber': instance.maxNumber,
      'stats': instance.stats.map((k, e) =>
          MapEntry(k, e.map((k, e) => MapEntry(_$UnitNormalityEnumMap[k], e)))),
      'actions': instance.actions,
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

const _$UnitTypeEnumMap = {
  UnitType.ancientArtillery: 0,
  UnitType.banditArcher: 1,
  UnitType.banditGuard: 2,
  UnitType.banditLeader: 'banditLeader',
  UnitType.blackImp: 'blackImp',
  UnitType.caveBear: 'caveBear',
  UnitType.cityArcher: 'cityArcher',
  UnitType.cityGuard: 'cityGuard',
  UnitType.cultist: 'cultist',
  UnitType.darkRider: 'darkRider',
  UnitType.deepTerror: 'deepTerror',
  UnitType.earthDemon: 'earthDemon',
  UnitType.elderDrake: 'elderDrake',
  UnitType.flameDemon: 'flameDemon',
  UnitType.forestImp: 'forestImp',
  UnitType.frostDemon: 'frostDemon',
  UnitType.giantViper: 'giantViper',
  UnitType.guardCaptain: 'guardCaptain',
  UnitType.harrowerInfester: 'harrowerInfester',
  UnitType.hound: 'hound',
  UnitType.inoxArcher: 'inoxArcher',
  UnitType.inoxBodyguard: 'inoxBodyguard',
  UnitType.inoxGuard: 'inoxGuard',
  UnitType.inoxShaman: 'inoxShaman',
  UnitType.jekserah: 'jekserah',
  UnitType.livingBones: 'livingBones',
  UnitType.livingDead: 'livingDead',
  UnitType.livingSpirit: 'livingSpirit',
  UnitType.lurker: 'lurker',
  UnitType.mercilessOverseer: 'mercilessOverseer',
  UnitType.nightDemon: 'nightDemon',
  UnitType.ooze: 'ooze',
  UnitType.primeDemon: 'primeDemon',
  UnitType.rendingDrake: 'rendingDrake',
  UnitType.savassIcestorm: 'savassIcestorm',
  UnitType.savassLavaflow: 'savassLavaflow',
  UnitType.spiritDrake: 'spiritDrake',
  UnitType.stoneGolem: 'stoneGolem',
  UnitType.sunDemon: 'sunDemon',
  UnitType.bertayer: 'bertayer',
  UnitType.colorless: 'colorless',
  UnitType.gloom: 'gloom',
  UnitType.sightlessEye: 'sightlessEye',
  UnitType.vermlingScout: 'vermlingScout',
  UnitType.vermlingShaman: 'vermlingShaman',
  UnitType.windDemon: 'windDemon',
  UnitType.wingedHorror: 'wingedHorror',
  UnitType.aestherAshblade: 99999,
};

const _$UnitNormalityEnumMap = {
  UnitNormality.normal: 'normal',
  UnitNormality.elite: 'elite',
};
