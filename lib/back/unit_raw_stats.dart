import 'package:json_annotation/json_annotation.dart';

part 'unit_raw_stats.g.dart';

@JsonSerializable()
class UnitRawStats {
  final int health;
  final int? shield;
  final int? move;
  final int? attack;
  final int? range;
  final int? retaliate;
  @JsonKey(defaultValue: <String>[])
  final List<String>? perks;
  @JsonKey(defaultValue: <String>[])
  final List<String>? immune;

  UnitRawStats(
    this.health,
    this.shield,
    this.move,
    this.attack,
    this.range,
    this.retaliate,
    this.perks,
    this.immune,
  );

  factory UnitRawStats.fromJson(Map<String, dynamic> json) =>
      _$UnitRawStatsFromJson(json);
}
