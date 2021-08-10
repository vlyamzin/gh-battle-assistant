import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_raw_actions.g.dart';

@JsonSerializable()
class UnitRawAction {
  final int initiative;
  final bool shouldRefresh;
  final List<RawActionValue> values;
  final Map<ModifierType, int> modifier;

  UnitRawAction(this.initiative, this.shouldRefresh, this.values, this.modifier);

  factory UnitRawAction.fromJson(Map<String, dynamic> json) => _$UnitRawActionFromJson(json);
}

@JsonSerializable()
class RawActionValue {
  final String? title;
  final String? subtitle;
  final String? area;

  RawActionValue(this.title, this.subtitle, this.area);

  factory RawActionValue.fromJson(Map<String, dynamic> json) => _$RawActionValueFromJson(json);
}
