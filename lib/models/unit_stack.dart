import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';

class UnitStack with ChangeNotifier {
  late final String id;
  late final UnitType type;
  late final String displayName;
  late final List<Unit> units;
  late final List<UnitAction> actions;
  late final int? maxNumber;
  late final String? imgPath;
  late List<int> availableNumbersPull;

  // TODO generate hash is from displayName
  static String _generateId(UnitType type) {
    return '${type}123';
  }

  /// Creates [UnitStack] object with predefined data
  /// [id] The id of a particular stack. Is used in business logic and never shown in UI.
  /// [maxNumber] defines the maximum amount of units in the stack.
  /// Usually this value fluctuates between 6 and 10. Default is 6.
  /// [units] The list of monster units in the stack.
  /// [actions] The list of action cards
  /// [availableNumbersPull] The list of numbers from which a newly created unit can
  /// get it's [Unit.number] value
  UnitStack({
    required this.id,
    required this.type,
    required this.displayName,
    this.maxNumber = 6,
    List<Unit>? units,
    List<UnitAction>? actions,
    List<int>? availableNumbersPull,
  }) {
    this.availableNumbersPull =
        availableNumbersPull ?? _getAvailableNumbersPull(this.maxNumber!);
    if (units == null) this.units = <Unit>[];
    if (actions == null) this.actions = <UnitAction>[];
  }

  /// Creates [UnitStack] object and automatically generates [id]
  UnitStack.withId({
    required UnitType type,
    required String displayName,
    List<Unit>? units,
    List<UnitAction>? actions,
    int? maxNumber,
  }) : this(
          type: type,
          displayName: displayName,
          id: _generateId(type),
          units: units,
          actions: actions,
          maxNumber: maxNumber,
        );

  /// Creates [UnitStack] object from json data
  UnitStack.fromJson(Map<String, dynamic> json) {
    if (json['type'] == null) throw NoUnitTypeError();

    type = json['type'];
    actions = _createActions(json['actions']);
    units = _createUnits(json['units']);
    id = json['id'] ?? _generateId(type);
    maxNumber = json['maxNumber'] ?? 6;
    displayName = json['displayName'];
    availableNumbersPull = json['availableNumbersPull'] ??
        _getAvailableNumbersPull(maxNumber!);
  }

  /// Adds [Unit] object to the list of [units]
  void addUnit(Unit newUnit) {
    var randomIndex = Random().nextInt(availableNumbersPull.length);
    newUnit.number = availableNumbersPull.removeAt(randomIndex);
    units.add(newUnit);
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
}

class NoUnitTypeError extends Error {
  @override
  String toString() => 'Empty Unit Type';
}
