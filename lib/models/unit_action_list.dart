import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_action_list.g.dart';

@JsonSerializable()
class UnitActionList {
  UnitAction? currentAction;
  List<int>? availableActionIndexes;

  @JsonKey(ignore: true)
  late List<UnitAction> allActions;

  UnitActionList({this.currentAction, this.availableActionIndexes});

  factory UnitActionList.fromJson(Map<String, dynamic> json) =>
      _$UnitActionListFromJson(json);

  Map<String, dynamic> toJson() => _$UnitActionListToJson(this);
}
