// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_raw_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitRawData _$UnitRawDataFromJson(Map<String, dynamic> json) => UnitRawData(
      $enumDecode(_$UnitTypeEnumMap, json['id']),
      json['name'] as String,
      json['maxNumber'] as int,
      (json['actions'] as List<dynamic>)
          .map((e) => UnitRawAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['stats'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry($enumDecode(_$UnitNormalityEnumMap, k),
                  UnitRawStats.fromJson(e as Map<String, dynamic>)),
            )),
      ),
      json['flying'] as bool? ?? false,
    );

Map<String, dynamic> _$UnitRawDataToJson(UnitRawData instance) =>
    <String, dynamic>{
      'id': _$UnitTypeEnumMap[instance.id],
      'name': instance.name,
      'flying': instance.flying,
      'maxNumber': instance.maxNumber,
      'stats': instance.stats.map((k, e) =>
          MapEntry(k, e.map((k, e) => MapEntry(_$UnitNormalityEnumMap[k], e)))),
      'actions': instance.actions,
    };

const _$UnitTypeEnumMap = {
  UnitType.ancientArtillery: 0,
  UnitType.banditArcher: 1,
  UnitType.banditGuard: 2,
  UnitType.banditCommander: 3,
  UnitType.blackImp: 4,
  UnitType.caveBear: 5,
  UnitType.cityArcher: 6,
  UnitType.cityGuard: 7,
  UnitType.cultist: 8,
  UnitType.darkRider: 9,
  UnitType.deepTerror: 10,
  UnitType.earthDemon: 11,
  UnitType.elderDrake: 12,
  UnitType.flameDemon: 13,
  UnitType.forestImp: 14,
  UnitType.frostDemon: 15,
  UnitType.giantViper: 16,
  UnitType.guardCaptain: 17,
  UnitType.harrowerInfester: 18,
  UnitType.hound: 19,
  UnitType.inoxArcher: 20,
  UnitType.inoxBodyguard: 21,
  UnitType.inoxGuard: 22,
  UnitType.inoxShaman: 23,
  UnitType.jekserah: 24,
  UnitType.livingBones: 25,
  UnitType.livingCorpse: 26,
  UnitType.livingSpirit: 27,
  UnitType.lurker: 28,
  UnitType.mercilessOverseer: 29,
  UnitType.nightDemon: 30,
  UnitType.ooze: 31,
  UnitType.primeDemon: 32,
  UnitType.rendingDrake: 33,
  UnitType.savassIcestorm: 34,
  UnitType.savassLavaflow: 35,
  UnitType.spittingDrake: 36,
  UnitType.stoneGolem: 37,
  UnitType.sunDemon: 38,
  UnitType.bertayer: 39,
  UnitType.colorless: 40,
  UnitType.gloom: 41,
  UnitType.sightlessEye: 42,
  UnitType.vermlingScout: 43,
  UnitType.vermlingShaman: 44,
  UnitType.windDemon: 45,
  UnitType.wingedHorror: 46,
  UnitType.aestherAshblade: 99999,
};

const _$UnitNormalityEnumMap = {
  UnitNormality.normal: 'normal',
  UnitNormality.elite: 'elite',
};
