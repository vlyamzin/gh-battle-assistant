import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/enums/activity_type.dart';

part 'unit_action.g.dart';

@JsonSerializable()
class UnitAction {
  final int id;
  late final int initiative;
  late final List<GHAction> values;
  late final Map<ModifierType, int> modifiers;
  late final bool? shouldRefresh;
  @JsonKey(defaultValue: <ActivityType>[])
  late final List<ActivityType> perks;
  @JsonKey(defaultValue: <String>[])
  late final List<String> area;

  UnitAction({
    required this.id,
    required this.initiative,
    List<GHAction>? values,
    Map<ModifierType, int>? modifiers,
    this.shouldRefresh,
    List<ActivityType>? perks,
    List<String>? area,
  }) {
    this.values = values ?? [];
    this.modifiers = modifiers ?? <ModifierType, int>{};
    this.perks = perks ?? [];
    this.area = area ?? [];
  }

  factory UnitAction.fromJson(Map<String, dynamic> json) =>
      _$UnitActionFromJson(json);

  factory UnitAction.fromRawData(UnitRawAction data) {
    return UnitAction(
      id: data.id,
      initiative: data.initiative,
      modifiers: data.modifier,
      shouldRefresh: data.shouldRefresh,
      values: data.values
          .map((e) =>
              GHAction(title: e.title, subtitle: e.subtitle, area: e.area))
          .toList(),
      perks: UnitAction.serializeRawData(data.perks),
      area: data.area,
    );
  }

  Map<String, dynamic> toJson() => _$UnitActionToJson(this);

  static List<ActivityType>? serializeRawData(List<String>? list) {
    return list?.map((value) {
      switch (value) {
        case 'pierce':
          return ActivityType.pierce;
        case 'poison':
          return ActivityType.poison;
        case 'wound':
          return ActivityType.wound;
        case 'disarm':
          return ActivityType.stun;
        case 'immobilize':
          return ActivityType.immobilize;
        case 'muddle':
          return ActivityType.muddle;
        case 'curse':
          return ActivityType.curse;
        case 'bless':
          return ActivityType.bless;
        case 'stun':
          return ActivityType.stun;
        case 'invisible':
          return ActivityType.invisible;
        case 'strengthen':
          return ActivityType.strengthen;
        case 'pull':
          return ActivityType.pull;
        case 'push':
          return ActivityType.push;
        case 'heal':
          return ActivityType.heal;
        case 'target_2':
          return ActivityType.target_2;
        case 'target_3':
          return ActivityType.target_3;
        case 'target_4':
          return ActivityType.target_4;
        case 'target_all':
          return ActivityType.target_all;
        default:
          throw Exception('Serialize raw data exception');
      }
    }).toList();
  }
}

@JsonSerializable()
class GHAction {
  String? title;
  String? subtitle;
  String? area;

  GHAction({this.title, this.subtitle, this.area});

  factory GHAction.fromJson(Map<String, dynamic> json) =>
      _$GHActionFromJson(json);

  Map<String, dynamic> toJson() => _$GHActionToJson(this);
}
