// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemies_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EnemiesInitial _$$_EnemiesInitialFromJson(Map<String, dynamic> json) =>
    _$_EnemiesInitial(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_EnemiesInitialToJson(_$_EnemiesInitial instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$EnemiesLoaded _$$EnemiesLoadedFromJson(Map<String, dynamic> json) =>
    _$EnemiesLoaded(
      Enemies.fromJson(json['enemies'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EnemiesLoadedToJson(_$EnemiesLoaded instance) =>
    <String, dynamic>{
      'enemies': instance.enemies,
      'runtimeType': instance.$type,
    };
