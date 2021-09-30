import 'dart:math';

import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_action_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_stack.g.dart';

@JsonSerializable()
class UnitStack {
  late final UnitType type;
  late final String displayName;
  late final List<Unit> units;
  late final UnitActionList actions;
  late int? maxNumber;

  late List<int> availableNumbersPull;

  /// Creates [UnitStack] object with predefined data
  /// [maxNumber] defines the maximum amount of units in the stack.
  /// Usually this value fluctuates between 6 and 10. Default is 6.
  /// [units] The list of monster units in the stack.
  /// [actions] The list of action cards
  /// [availableNumbersPull] The list of numbers from which a newly created unit can
  /// get it's [Unit.number] value
  UnitStack({
    required this.type,
    required this.displayName,
    this.maxNumber = 6,
    List<Unit>? units,
    UnitActionList? actions,
    List<int>? availableNumbersPull,
  }) {
    this.availableNumbersPull =
        availableNumbersPull ?? _getAvailableNumbersPull(this.maxNumber!);
    this.units = units ?? <Unit>[];
    this.actions = actions ?? UnitActionList();
  }

  /// Creates [UnitStack] object from another [UnitStack]
  UnitStack.copy(UnitStack stack)
      : this(
            type: stack.type,
            displayName: stack.displayName,
            maxNumber: stack.maxNumber,
            units: stack.units.toList(),
            actions: stack.actions,
            availableNumbersPull: stack.availableNumbersPull.toList());

  /// Creates [UnitStack] object from json data
  factory UnitStack.fromJson(Map<String, dynamic> json) =>
      _$UnitStackFromJson(json);

  /// Create [UnitStack] instance from [UnitRawData]
  factory UnitStack.fromRawData(UnitRawData data) {
    return UnitStack(
      type: data.id,
      displayName: data.name,
      maxNumber: data.maxNumber,
    );
  }

  /// Create a new copy of [UnitStack] with updated data
  UnitStack copyWith(
      {UnitType? type,
      String? displayName,
      int? maxNumber,
      List<Unit>? units,
      UnitActionList? actions,
      List<int>? availableNumbersPull}) {
    return UnitStack(
      type: type ?? this.type,
      displayName: displayName ?? this.displayName,
      maxNumber: maxNumber ?? this.maxNumber,
      units: units ?? this.units.toList(),
      actions: actions ?? this.actions,
      availableNumbersPull:
          availableNumbersPull ?? this.availableNumbersPull.toList(),
    );
  }

  /// Convert [UnitStack] object to json
  Map<String, dynamic> toJson() => _$UnitStackToJson(this);

  bool get isEmpty => units.isEmpty;

  /// Adds [Unit] object to the list of [units]
  /// Decreases the maximum unit number
  void addUnit(Unit newUnit) {
    var randomIndex = Random().nextInt(availableNumbersPull.length);
    newUnit.number = availableNumbersPull.removeAt(randomIndex);
    units.add(newUnit);
    maxNumber = maxNumber! - 1;
  }

  /// Removes [Unit] object from the list of [units]
  /// Return number back into [availableNumbersPull]
  /// Increases the maximum unit number
  void removeUnit(int number) {
    units.removeWhere((element) => element.number == number);
    availableNumbersPull.add(number);
    maxNumber = maxNumber! + 1;
  }

  /// Returns the list of numbers started from 1 till the [n]
  List<int> _getAvailableNumbersPull(int n) {
    return List.generate(n, (index) => index + 1);
  }
}
