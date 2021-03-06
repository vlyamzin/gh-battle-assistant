// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_raw_actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitRawAction _$UnitRawActionFromJson(Map<String, dynamic> json) =>
    UnitRawAction(
      json['id'] as int,
      json['initiative'] as int,
      json['shouldRefresh'] as bool,
      (json['values'] as List<dynamic>)
          .map((e) => RawActionValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['modifier'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$ModifierTypeEnumMap, k), e),
      ),
      (json['perks'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      (json['perkValue'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          {},
      (json['area'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );

Map<String, dynamic> _$UnitRawActionToJson(UnitRawAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'initiative': instance.initiative,
      'shouldRefresh': instance.shouldRefresh,
      'values': instance.values,
      'modifier': instance.modifier
          .map((k, e) => MapEntry(_$ModifierTypeEnumMap[k], e)),
      'perks': instance.perks,
      'perkValue': instance.perkValue,
      'area': instance.area,
    };

const _$ModifierTypeEnumMap = {
  ModifierType.attack: 'attack',
  ModifierType.range: 'range',
  ModifierType.move: 'move',
  ModifierType.shield: 'shield',
  ModifierType.retaliate: 'retaliate',
  ModifierType.retaliateRange: 'retaliateRange',
  ModifierType.suffer: 'suffer',
  ModifierType.heal: 'heal',
};

RawActionValue _$RawActionValueFromJson(Map<String, dynamic> json) =>
    RawActionValue(
      json['title'] as String?,
      json['subtitle'] as String?,
      json['area'] as String?,
    );

Map<String, dynamic> _$RawActionValueToJson(RawActionValue instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'area': instance.area,
    };
