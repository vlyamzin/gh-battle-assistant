import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit {
  int? _number;
  late final String displayName;
  late int healthPoint;
  late int shield;
  late int? attack;
  late int? range;
  late int? move;
  late int? retaliate;
  late int suffer;
  late int pierced;
  @JsonKey(defaultValue: <ActivityType>[])
  late final List<ActivityType>? perks;
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
    this.pierced = 0,
    this.elite = false,
    this.turnEnded = false,
    List<ActivityType>? perks,
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

  factory Unit.fromRawData({
    int? number,
    required displayName,
    required healthPoint,
    shield = 0,
    attack = 0,
    range = 0,
    move = 0,
    retaliate = 0,
    suffer = 0,
    pierced = 0,
    elite = false,
    turnEnded = false,
    List<String>? perks,
    List<String>? immune,
    Set<ActivityType>? negativeEffects,
  }) {
    var sPerks = serializeRawData(perks);
    var sImmune = serializeRawData(immune);

    return Unit(
      displayName: displayName,
      healthPoint: healthPoint,
      number: number,
      shield: shield,
      attack: attack,
      range: range,
      move: move,
      retaliate: retaliate,
      suffer: suffer,
      pierced: pierced,
      elite: elite,
      negativeEffects: negativeEffects,
      perks: sPerks,
      immune: sImmune,
    );
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

  void applyNegativeEffects() {
    applyWound();
    applyDisarm();
    applyMuddle();
    applyPeirce();
    applyStrengthen();
    applyStun();
    applySuffer();
    applyInvisible();
    applyImmobilize();
  }

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

  void applyInvisible() => negativeEffects?.remove(ActivityType.invisible);

  void applyImmobilize() => negativeEffects?.remove(ActivityType.immobilize);

  void applyMuddle() => negativeEffects?.remove(ActivityType.muddle);

  void applyDisarm() => negativeEffects?.remove(ActivityType.disarm);

  void applyPeirce() {
    negativeEffects?.remove(ActivityType.pierce);
    pierced = 0;
  }

  void applyStrengthen() => negativeEffects?.remove(ActivityType.strengthen);

  static List<ActivityType>? serializeRawData(List<String>? list) {
    return list?.map((value) {
      switch (value) {
        case 'pierce':
          return ActivityType.pierce;
        case 'poison':
          return ActivityType.poison;
        case 'wound':
          return ActivityType.wound;
        case 'disarm':
          return ActivityType.stun;
        case 'immobilize':
          return ActivityType.immobilize;
        case 'muddle':
          return ActivityType.muddle;
        case 'curse':
          return ActivityType.curse;
        case 'bless':
          return ActivityType.bless;
        case 'stun':
          return ActivityType.stun;
        case 'invisible':
          return ActivityType.invisible;
        case 'strengthen':
          return ActivityType.strengthen;
        case 'target_2':
          return ActivityType.target_2;
        case 'target_3':
          return ActivityType.target_3;
        case 'target_4':
          return ActivityType.target_4;
        case 'target_all':
          return ActivityType.target_all;
        default:
          throw Exception('Serialize raw data exception');
      }
    }).toList();
  }
}
