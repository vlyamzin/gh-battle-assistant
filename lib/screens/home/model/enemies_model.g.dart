// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enemies _$EnemiesFromJson(Map<String, dynamic> json) => Enemies(
      monsters: (json['monsters'] as List<dynamic>)
          .map((e) => UnitStack.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EnemiesToJson(Enemies instance) => <String, dynamic>{
      'monsters': instance.monsters.map((e) => e.toJson()).toList(),
    };
