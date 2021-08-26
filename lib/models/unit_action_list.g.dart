// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_action_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitActionList _$UnitActionListFromJson(Map<String, dynamic> json) {
  return UnitActionList(
    currentAction: json['currentAction'] == null
        ? null
        : UnitAction.fromJson(json['currentAction'] as Map<String, dynamic>),
    availableActionIndexes: (json['availableActionIndexes'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );
}

Map<String, dynamic> _$UnitActionListToJson(UnitActionList instance) =>
    <String, dynamic>{
      'currentAction': instance.currentAction,
      'availableActionIndexes': instance.availableActionIndexes,
    };
