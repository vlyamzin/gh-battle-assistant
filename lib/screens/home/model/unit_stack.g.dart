// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitStack _$UnitStackFromJson(Map<String, dynamic> json) => UnitStack(
      type: $enumDecode(_$UnitTypeEnumMap, json['type']),
      displayName: json['displayName'] as String,
      maxNumber: json['maxNumber'] as int? ?? 6,
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => Unit.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: json['actions'] == null
          ? null
          : UnitActionList.fromJson(json['actions'] as Map<String, dynamic>),
      availableNumbersPull: (json['availableNumbersPull'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      turnState: $enumDecodeNullable(_$TurnStateEnumMap, json['turnState']) ??
          TurnState.idle,
    );

Map<String, dynamic> _$UnitStackToJson(UnitStack instance) => <String, dynamic>{
      'type': _$UnitTypeEnumMap[instance.type],
      'displayName': instance.displayName,
      'units': instance.units,
      'actions': instance.actions,
      'maxNumber': instance.maxNumber,
      'availableNumbersPull': instance.availableNumbersPull,
      'turnState': _$TurnStateEnumMap[instance.turnState],
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
  UnitType.betrayer: 39,
  UnitType.colorless: 40,
  UnitType.gloom: 41,
  UnitType.sightlessEye: 42,
  UnitType.vermlingScout: 43,
  UnitType.vermlingShaman: 44,
  UnitType.windDemon: 45,
  UnitType.wingedHorror: 46,
  UnitType.aestherAshblade: 99999,
};

const _$TurnStateEnumMap = {
  TurnState.idle: 0,
  TurnState.started: 1,
  TurnState.ended: 2,
};
