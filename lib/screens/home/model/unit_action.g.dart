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
        (k, e) => MapEntry($enumDecode(_$ModifierTypeEnumMap, k), e as int),
      ),
      shouldRefresh: json['shouldRefresh'] as bool?,
      perks: (json['perks'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ActivityTypeEnumMap, e))
              .toList() ??
          [],
      perkValue: (json['perkValue'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry($enumDecode(_$ActivityTypeEnumMap, k), e as String),
          ) ??
          {},
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
      'perkValue': instance.perkValue
          .map((k, e) => MapEntry(_$ActivityTypeEnumMap[k], e)),
      'area': instance.area,
    };

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
  ActivityType.target: 'target',
  ActivityType.invisible: 'invisible',
  ActivityType.advantage: 'advantage',
  ActivityType.disadvantage: 'disadvantage',
  ActivityType.shield: 'shield',
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
