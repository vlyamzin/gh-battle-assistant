import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';

class UnitStack with ChangeNotifier {
  late final UnitType type;
  late final String displayName;
  late final List<Unit> units;
  late final List<UnitAction> actions;
  late int? maxNumber;
  late final String? imgPath;
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
    List<UnitAction>? actions,
    List<int>? availableNumbersPull,
  }) {
    this.availableNumbersPull =
        availableNumbersPull ?? _getAvailableNumbersPull(this.maxNumber!);
    this.units = units ?? <Unit>[];
    this.actions = actions ?? <UnitAction>[];
  }

  /// Creates [UnitStack] object from another [UnitStack]
  UnitStack.copy(UnitStack stack)
      : this(
            type: stack.type,
            displayName: stack.displayName,
            maxNumber: stack.maxNumber,
            units: stack.units.toList(),
            actions: stack.actions.toList(),
            availableNumbersPull: stack.availableNumbersPull.toList());

  /// Creates [UnitStack] object from json data
  UnitStack.fromJson(Map<String, dynamic> json) {
    if (json['type'] == null) throw NoUnitTypeError();

    type = json['type'];
    actions = _createActions(json['actions']);
    units = _createUnits(json['units']);
    maxNumber = json['maxNumber'] ?? 6;
    displayName = json['displayName'];
    availableNumbersPull =
        json['availableNumbersPull'] ?? _getAvailableNumbersPull(maxNumber!);
  }

  /// Create a new copy of [UnitStack] with updated data
  UnitStack copyWith(
      {UnitType? type,
        String? displayName,
        int? maxNumber,
        List<Unit>? units,
        List<UnitAction>? actions,
        List<int>? availableNumbersPull}) {
    return UnitStack(
        type: type ?? this.type,
        displayName: displayName ?? this.displayName,
        maxNumber: maxNumber ?? this.maxNumber,
        units: units ?? this.units.toList(),
        actions: actions ?? this.actions.toList(),
        availableNumbersPull: availableNumbersPull ?? this.availableNumbersPull.toList(),
    );
  }

  /// Adds [Unit] object to the list of [units]
  /// Decreases the maximum unit number
  void addUnit(Unit newUnit) {
    var randomIndex = Random().nextInt(availableNumbersPull.length);
    newUnit.number = availableNumbersPull.removeAt(randomIndex);
    units.add(newUnit);
    maxNumber = maxNumber! - 1;
  }

  /// Removes [Unit] object from the lust of [units]
  /// Increases the maximum unit number
  void removeUnit(int number) {
    units.removeWhere((element) => element.number == number);
    maxNumber = maxNumber! + 1;
  }

  /// Creates and returns the list of [units] based on json data
  List<Unit> _createUnits(List<Map>? units) {
    return (units ?? []).map((e) => Unit.fromJson(e)).toList();
  }

  List<UnitAction> _createActions(List<Map>? actions) {
    return (actions ?? []).map((e) => UnitAction.fromJson(e)).toList();
  }

  /// Returns the list of numbers started from 1 till the [n]
  List<int> _getAvailableNumbersPull(int n) {
    return List.generate(n, (index) => index + 1);
  }

  @override
  String toString() {
    return 'Stack $displayName with units count: ${units.length}';
  }
}

class NoUnitTypeError extends Error {
  @override
  String toString() => 'Empty Unit Type';
}
