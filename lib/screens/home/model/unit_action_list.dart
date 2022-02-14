import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'unit_action_list.g.dart';

@JsonSerializable()
@immutable
class UnitActionList extends Equatable {
  final UnitAction? currentAction;
  final List<int>? availableActionIndexes;
  final List<UnitAction>? allActions;

  UnitActionList({
    this.currentAction,
    this.availableActionIndexes,
    this.allActions,
  });

  factory UnitActionList.fromJson(Map<String, dynamic> json) =>
      _$UnitActionListFromJson(json);

  Map<String, dynamic> toJson() => _$UnitActionListToJson(this);

  UnitActionList copyWith(
      {UnitAction? currentAction,
      List<int>? availableActionIndexes,
      List<UnitAction>? allActions}) {
    return UnitActionList(
      currentAction: currentAction ?? this.currentAction,
      availableActionIndexes:
          availableActionIndexes ?? this.availableActionIndexes,
      allActions: allActions ?? this.allActions,
    );
  }

  @override
  List<Object?> get props =>
      [currentAction, availableActionIndexes, allActions];
}
