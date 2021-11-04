import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/common/mixins/action_type_serializer_mixin.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/enums/activity_type.dart';

part 'unit_action.g.dart';

@JsonSerializable()
@immutable
class UnitAction extends Equatable with ActionTypeSerializer {
  final int id;
  late final int initiative;
  late final List<GHAction> values;
  late final Map<ModifierType, int> modifiers;
  late final bool? shouldRefresh;
  @JsonKey(defaultValue: <ActivityType>[])
  late final List<ActivityType> perks;
  @JsonKey(defaultValue: <ActivityType, String>{})
  late final Map<ActivityType, String> perkValue;
  @JsonKey(defaultValue: <String>[])
  late final List<String> area;

  UnitAction({
    required this.id,
    required this.initiative,
    List<GHAction>? values,
    Map<ModifierType, int>? modifiers,
    this.shouldRefresh,
    List<ActivityType>? perks,
    Map<ActivityType, String>? perkValue,
    List<String>? area,
  }) {
    this.values = values ?? [];
    this.modifiers = modifiers ?? <ModifierType, int>{};
    this.perks = perks ?? [];
    this.perkValue = perkValue ?? <ActivityType, String>{};
    this.area = area ?? [];
  }

  factory UnitAction.fromJson(Map<String, dynamic> json) =>
      _$UnitActionFromJson(json);

  factory UnitAction.fromRawData(UnitRawAction data) {
    var sPerks, sPerkValue;

    try {
      sPerks = ActionTypeSerializer.serializeRawData(data.perks);
      sPerkValue = ActionTypeSerializer.serializeRawPerkValue(data.perkValue);
    } catch (e) {
      di<LoggerService>().log(e.toString());
    }

    return UnitAction(
      id: data.id,
      initiative: data.initiative,
      modifiers: data.modifier,
      shouldRefresh: data.shouldRefresh,
      values: data.values
          .map((e) =>
              GHAction(title: e.title, subtitle: e.subtitle, area: e.area))
          .toList(),
      perks: sPerks,
      perkValue: sPerkValue,
      area: data.area,
    );
  }

  Map<String, dynamic> toJson() => _$UnitActionToJson(this);

  UnitAction copyWith({
    int? id,
    int? initiative,
    List<GHAction>? values,
    Map<ModifierType, int>? modifiers,
    bool? shouldRefresh,
    List<ActivityType>? perks,
    List<String>? area,
  }) {
    return UnitAction(
      id: id ?? this.id,
      initiative: initiative ?? this.initiative,
      values: values ?? this.values,
      modifiers: modifiers ?? this.modifiers,
      shouldRefresh: shouldRefresh ?? this.shouldRefresh,
      perks: perks ?? this.perks,
      area: area ?? this.area,
    );
  }

  @override
  List<Object?> get props =>
      [id, initiative, shouldRefresh, values, modifiers, perks, area];
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
