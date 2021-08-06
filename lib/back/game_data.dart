import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_data.g.dart';

@JsonSerializable()
class GameData {
  late final List<UnitRawData> monsters;

  GameData(this.monsters);

  factory GameData.fromJson(Map<String, dynamic> json) => _$GameDataFromJson(json);

  UnitRawData getUnitDataById(UnitType id) => monsters.firstWhere((element) => element.id == id);
  UnitRawData getUnitDataByName(String query) => monsters.firstWhere((element) => element.name == query);

}
