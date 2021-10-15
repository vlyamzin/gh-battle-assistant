// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) => Home(
      monsters: (json['monsters'] as List<dynamic>?)
          ?.map((e) => UnitStack.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'monsters': instance.monsters.map((e) => e.toJson()).toList(),
    };
