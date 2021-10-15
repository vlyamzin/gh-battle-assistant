// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitAction _$UnitActionFromJson(Map<String, dynamic> json) => UnitAction(
      id: json['id'] as int,
      initiative: json['initiative'] as int,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => GHAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      modifiers: (json['modifiers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(_$enumDecode(_$ModifierTypeEnumMap, k), e as int),
      ),
      shouldRefresh: json['shouldRefresh'] as bool?,
      perks: (json['perks'] as List<dynamic>?)
              ?.map((e) => _$enumDecode(_$ActivityTypeEnumMap, e))
              .toList() ??
          [],
      area:
          (json['area'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$UnitActionToJson(UnitAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'initiative': instance.initiative,
      'values': instance.values,
      'modifiers': instance.modifiers
          .map((k, e) => MapEntry(_$ModifierTypeEnumMap[k], e)),
      'shouldRefresh': instance.shouldRefresh,
      'perks': instance.perks.map((e) => _$ActivityTypeEnumMap[e]).toList(),
      'area': instance.area,
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
  ModifierType.shield: 'shield',
  ModifierType.retaliate: 'retaliate',
  ModifierType.suffer: 'suffer',
  ModifierType.heal: 'heal',
};

const _$ActivityTypeEnumMap = {
  ActivityType.attack: 'attack',
  ActivityType.heal: 'heal',
  ActivityType.suffer: 'suffer',
  ActivityType.pierce: 'pierce',
  ActivityType.poison: 'poison',
  ActivityType.wound: 'wound',
  ActivityType.disarm: 'disarm',
  ActivityType.stun: 'stun',
  ActivityType.immobilize: 'immobilize',
  ActivityType.muddle: 'muddle',
  ActivityType.curse: 'curse',
  ActivityType.bless: 'bless',
  ActivityType.strengthen: 'strengthen',
  ActivityType.pull: 'pull',
  ActivityType.push: 'push',
  ActivityType.target_2: 'target_2',
  ActivityType.target_3: 'target_3',
  ActivityType.target_4: 'target_4',
  ActivityType.target_all: 'target_all',
  ActivityType.invisible: 'invisible',
};

GHAction _$GHActionFromJson(Map<String, dynamic> json) => GHAction(
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      area: json['area'] as String?,
    );

Map<String, dynamic> _$GHActionToJson(GHAction instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'area': instance.area,
    };
