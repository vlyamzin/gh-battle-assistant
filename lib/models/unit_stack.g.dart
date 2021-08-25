// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitStack _$UnitStackFromJson(Map<String, dynamic> json) {
  return UnitStack(
    type: _$enumDecode(_$UnitTypeEnumMap, json['type']),
    displayName: json['displayName'] as String,
    maxNumber: json['maxNumber'] as int?,
    units: (json['units'] as List<dynamic>?)
        ?.map((e) => Unit.fromJson(e as Map<String, dynamic>))
        .toList(),
    actions: (json['actions'] as List<dynamic>?)
        ?.map((e) => UnitAction.fromJson(e as Map<String, dynamic>))
        .toList(),
    availableNumbersPull: (json['availableNumbersPull'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );
}

Map<String, dynamic> _$UnitStackToJson(UnitStack instance) => <String, dynamic>{
      'type': _$UnitTypeEnumMap[instance.type],
      'displayName': instance.displayName,
      'units': instance.units,
      'actions': instance.actions,
      'maxNumber': instance.maxNumber,
      'availableNumbersPull': instance.availableNumbersPull,
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
