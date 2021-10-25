// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_raw_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitRawStats _$UnitRawStatsFromJson(Map<String, dynamic> json) => UnitRawStats(
      json['health'] as int,
      json['shield'] as int,
      json['move'] as int?,
      json['attack'] as int?,
      json['range'] as int?,
      json['retaliate'] as int,
      (json['perks'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      (json['immune'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
    );

Map<String, dynamic> _$UnitRawStatsToJson(UnitRawStats instance) =>
    <String, dynamic>{
      'health': instance.health,
      'shield': instance.shield,
      'move': instance.move,
      'attack': instance.attack,
      'range': instance.range,
      'retaliate': instance.retaliate,
      'perks': instance.perks,
      'immune': instance.immune,
    };
