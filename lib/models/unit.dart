
import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit {
  int? _number;
  late final String displayName;
  late final int healthPoint;
  late final int? shield;
  late final int? attack;
  late final int? range;
  late final int? move;
  late final int? retaliate;
  @JsonKey(defaultValue: [])
  late final List? perks;
  late final bool? elite;

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
    List? perks
  }) {
    if (number != null) this._number = number;
    if (perks == null) this.perks = [];
    else this.perks = perks;
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
