import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/turn_state.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/screens/stats/model/unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'unit_stack.g.dart';

@JsonSerializable()
@immutable
class UnitStack extends Equatable {
  final UnitType type;
  final String displayName;
  late final List<Unit> units;
  late final UnitActionList actions;
  final int? maxNumber;
  late final List<int> availableNumbersPull;
  final TurnState turnState;

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
    this.turnState = TurnState.idle,
  }) {
    this.availableNumbersPull =
        availableNumbersPull ?? _getAvailableNumbersPull(this.maxNumber!);
    this.units = units ?? <Unit>[];
    this.actions = actions ?? UnitActionList();
  }

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
      List<int>? availableNumbersPull,
      TurnState? turnState}) {
    return UnitStack(
      type: type ?? this.type,
      displayName: displayName ?? this.displayName,
      maxNumber: maxNumber ?? this.maxNumber,
      units: units != null ? [...units] : this.units.toList(),
      actions: actions ?? this.actions,
      availableNumbersPull:
          availableNumbersPull ?? this.availableNumbersPull.toList(),
      turnState: turnState ?? this.turnState,
    );
  }

  /// Convert [UnitStack] object to json
  Map<String, dynamic> toJson() => _$UnitStackToJson(this);

  /// Stack is empty in case it does not have any [Unit] object inside
  bool get isEmpty => units.isEmpty;

  Unit getUnitByNumber(int number) {
    if (units.isNotEmpty)
      return units.firstWhere((unit) => unit.number == number);
    else
      throw StateError('Units list is empty');
  }

  /// Adds [Unit] object to the list of [units]
  UnitStack addUnit(Unit newUnit) {
    return copyWith(
      units: [...units, newUnit],
    );
  }

  UnitStack updateUnit(Unit newUnit) {
    return copyWith(
        units: units
            .map((unit) => unit.number == newUnit.number ? newUnit : unit)
            .toList());
  }

  /// Removes [Unit] object from the list of [units]
  /// /// Return number back into [availableNumbersPull]
  /// Increases the maximum unit number
  UnitStack removeUnit(int number) {
    var updatedList = [...units]
      ..removeWhere((element) => element.number == number);
    availableNumbersPull.add(number);
    availableNumbersPull.sort((a, b) => a - b);
    return copyWith(
      units: updatedList,
      availableNumbersPull: [...availableNumbersPull],
    );
  }

  List<Unit> shuffleUnits(List<Unit> units) {
    var pulledNumbers = <int>{};

    return [...units].map((unit) {
      var randomIndex = new Random().nextInt(availableNumbersPull.length);

      while (pulledNumbers.contains(randomIndex)) {
        randomIndex = new Random().nextInt(availableNumbersPull.length);
      }

      pulledNumbers.add(randomIndex);
      return unit.copyWith(number: availableNumbersPull[randomIndex]);
    }).toList();
  }

  /// Returns the list of numbers started from 1 till the [n]
  List<int> _getAvailableNumbersPull(int n) {
    return List.generate(n, (index) => index + 1);
  }

  @override
  List<Object?> get props =>
      [type, displayName, units, actions, availableNumbersPull, turnState];
}
