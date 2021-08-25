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
    elite: json['elite'] as bool?,
    perks: json['perks'] as List<dynamic>? ?? [],
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
      'perks': instance.perks,
      'elite': instance.elite,
      'number': instance.number,
    };
