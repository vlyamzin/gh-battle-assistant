import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'enemies_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Enemies extends Equatable {
  final List<UnitStack> monsters;

  const Enemies({required this.monsters});

  factory Enemies.fromJson(Map<String, dynamic> json) =>
      _$EnemiesFromJson(json);

  Map<String, dynamic> toJson() => _$EnemiesToJson(this);

  UnitStack? getByType(UnitType type) {
    try {
      return monsters.firstWhere((element) => element.type == type);
    } on StateError catch (_) {
      return null;
    }
  }

  List<UnitStack> update(UnitStack newStack) {
    var exist = false;

    if (monsters.isEmpty) return <UnitStack>[newStack];

    var updated = monsters.map((element) {
      if (element.type == newStack.type) {
        exist = true;
        return newStack;
      } else
        return element;
    }).toList();

    if (exist)
      return updated;
    else
      return [...monsters, newStack];
  }

  @override
  List<Object?> get props => [monsters];
}
