import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/common/enums/unit_normality.dart';
import 'package:gh_battle_assistant/common/enums/unit_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_raw_data.g.dart';

typedef StatsByUnitNormalityMap = Map<UnitNormality, UnitRawStats>;
typedef UnitRawStatsMap = Map<String, StatsByUnitNormalityMap>;

@JsonSerializable()
class UnitRawData {
  final UnitType id;
  final String name;
  final bool flying;
  final int maxNumber;
  final UnitRawStatsMap stats;
  final List<UnitRawAction> actions;

  UnitRawData(
    this.id,
    this.name,
    this.maxNumber,
    this.actions,
    this.stats, [
    this.flying = false,
  ]);

  factory UnitRawData.fromJson(Map<String, dynamic> json) =>
      _$UnitRawDataFromJson(json);

  StatsByUnitNormalityMap? getUnitStats(String difficulty) => stats[difficulty];

  UnitRawStats? getUnitStatsByNormality(
          UnitNormality normality, String difficulty) =>
      stats[difficulty]?[normality];
}
