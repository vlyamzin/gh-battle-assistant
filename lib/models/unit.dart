import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit {
  int? _number;
  late final String displayName;
  late int healthPoint;
  late int? shield;
  late int? attack;
  late int? range;
  late int? move;
  late int? retaliate;
  @JsonKey(defaultValue: [])
  late final List? perks;
  @JsonKey(defaultValue: [])
  late final List<ActivityType>? immune;
  late final bool elite;

  Unit({
    int? number,
    required this.displayName,
    required this.healthPoint,
    this.shield = 0,
    this.attack = 0,
    this.range = 0,
    this.move = 0,
    this.retaliate = 0,
    this.elite = false,
    List? perks,
    List<ActivityType>? immune,
  }) {
    if (number != null) this._number = number;
    if (perks == null)
      this.perks = [];
    else
      this.perks = perks;
    if (immune == null)
      this.immune = <ActivityType>[];
    else
      this.immune = immune;
  }

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  int? get number => _number;

  set number(int? value) {
    if (_number != null) throw ArgumentError('Number already defined');
    if (value == null) throw ArgumentError('Number cant be null');

    _number = value;
  }

  String toString() => 'Unit$number: $displayName';
}
