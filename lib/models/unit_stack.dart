import 'dart:math';

import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:gh_battle_assistant/services/util_service.dart';
import 'package:json_annotation/json_annotation.dart';

import '../di.dart';

part 'unit_stack.g.dart';

@JsonSerializable()
class UnitStack {
  late final UnitType type;
  late final String displayName;
  late final List<Unit> units;
  late final List<UnitAction> actions;
  late int? maxNumber;

  @JsonKey(ignore: true)
  late UnitAction currentAction;
  @JsonKey(ignore: true)
  late final List<UnitAction> _allActions;

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
    this.currentAction = this.setAction();
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
  factory UnitStack.fromJson(Map<String, dynamic> json) => _$UnitStackFromJson(json);

  /// Create [UnitStack] instance from [UnitRawData]
  factory UnitStack.fromRawData(UnitRawData data) {
    final actions = data.actions
        .map((e) => UnitAction.fromRawData(e))
        .toList();

    return UnitStack(
      type: data.id,
      displayName: data.name,
      maxNumber: data.maxNumber,
      actions: actions
    );
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
      availableNumbersPull:
          availableNumbersPull ?? this.availableNumbersPull.toList(),
    );
  }

  /// Convert [UnitStack] object to json
  Map<String, dynamic> toJson() => _$UnitStackToJson(this);

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

  /// Returns the list of numbers started from 1 till the [n]
  List<int> _getAvailableNumbersPull(int n) {
    return List.generate(n, (index) => index + 1);
  }

  UnitAction setAction() {
    final rnd = di<UtilService>().randomize(actions.length);
    return actions.removeAt(rnd);
  }

  void shuffleActions() => actions.shuffle();


}
