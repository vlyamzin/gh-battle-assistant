// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitAction _$UnitActionFromJson(Map<String, dynamic> json) {
  return UnitAction(
    initiative: json['initiative'] as int,
    values: (json['values'] as List<dynamic>?)
        ?.map((e) => GHAction.fromJson(e as Map<String, dynamic>))
        .toList(),
    modifiers: (json['modifiers'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(_$enumDecode(_$ModifierTypeEnumMap, k), e as int),
    ),
    shouldRefresh: json['shouldRefresh'] as bool?,
  );
}

Map<String, dynamic> _$UnitActionToJson(UnitAction instance) =>
    <String, dynamic>{
      'initiative': instance.initiative,
      'values': instance.values,
      'modifiers': instance.modifiers
          .map((k, e) => MapEntry(_$ModifierTypeEnumMap[k], e)),
      'shouldRefresh': instance.shouldRefresh,
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
};

GHAction _$GHActionFromJson(Map<String, dynamic> json) {
  return GHAction(
    title: json['title'] as String?,
    subtitle: json['subtitle'] as String?,
    area: json['area'] as String?,
  );
}

Map<String, dynamic> _$GHActionToJson(GHAction instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'area': instance.area,
    };
