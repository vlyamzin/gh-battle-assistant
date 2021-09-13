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
  late int suffer;
  @JsonKey(defaultValue: [])
  late final List? perks;
  @JsonKey(defaultValue: <ActivityType>[])
  late final List<ActivityType>? immune;
  @JsonKey(defaultValue: <ActivityType>{})
  late final Set<ActivityType>? negativeEffects;
  late final bool elite;
  late bool turnEnded;

  Unit({
    int? number,
    required this.displayName,
    required this.healthPoint,
    this.shield = 0,
    this.attack = 0,
    this.range = 0,
    this.move = 0,
    this.retaliate = 0,
    this.suffer = 0,
    this.elite = false,
    this.turnEnded = false,
    List? perks,
    List<ActivityType>? immune,
    Set<ActivityType>? negativeEffects,
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

    negativeEffects == null
        ? this.negativeEffects = <ActivityType>{}
        : this.negativeEffects = negativeEffects;
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

  void applyWound() {
    if (negativeEffects?.contains(ActivityType.wound) == true) {
      healthPoint -= 1;
    }
  }

  void applySuffer() {
    healthPoint -= suffer;
    suffer = 0;
  }

  void applyStun() => negativeEffects?.remove(ActivityType.stun);

  void applyMuddle() => negativeEffects?.remove(ActivityType.muddle);

  void applyDisarm() => negativeEffects?.remove(ActivityType.disarm);

  void applyPeirce() => negativeEffects?.remove(ActivityType.pierce);

  void applyStrengthen() => negativeEffects?.remove(ActivityType.strengthen);
}
