// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_raw_actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitRawAction _$UnitRawActionFromJson(Map<String, dynamic> json) {
  return UnitRawAction(
    json['initiative'] as int,
    json['shouldRefresh'] as bool,
    (json['values'] as List<dynamic>)
        .map((e) => RawActionValue.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['modifier'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(_$enumDecode(_$ModifierTypeEnumMap, k), e as int),
    ),
    (json['perks'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  );
}

Map<String, dynamic> _$UnitRawActionToJson(UnitRawAction instance) =>
    <String, dynamic>{
      'initiative': instance.initiative,
      'shouldRefresh': instance.shouldRefresh,
      'values': instance.values,
      'modifier': instance.modifier
          .map((k, e) => MapEntry(_$ModifierTypeEnumMap[k], e)),
      'perks': instance.perks,
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

const _$ModifierTypeEnumMap = {
  ModifierType.attack: 'attack',
  ModifierType.range: 'range',
  ModifierType.move: 'move',
  ModifierType.health: 'health',
  ModifierType.shield: 'shield',
  ModifierType.retaliate: 'retaliate',
  ModifierType.suffer: 'suffer',
};

RawActionValue _$RawActionValueFromJson(Map<String, dynamic> json) {
  return RawActionValue(
    json['title'] as String?,
    json['subtitle'] as String?,
    json['area'] as String?,
  );
}

Map<String, dynamic> _$RawActionValueToJson(RawActionValue instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'area': instance.area,
    };
