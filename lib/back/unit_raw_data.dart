import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_raw_data.g.dart';

typedef StatsByUnitNormalityMap = Map<UnitNormality, UnitRawStats>;
typedef UnitRawStatsMap = Map<String, StatsByUnitNormalityMap>;

@JsonSerializable()
class UnitRawData {
  final UnitType id;
  final String name;
  final int maxNumber;
  final UnitRawStatsMap stats;
  // TODO add type
  final List<dynamic> actions;

  UnitRawData(this.id, this.name, this.maxNumber, this.actions, this.stats);

  factory UnitRawData.fromJson(Map<String, dynamic> json) => _$UnitRawDataFromJson(json);
}