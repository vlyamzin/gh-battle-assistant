import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_data.g.dart';

@JsonSerializable()
class GameData {
  late final List<UnitRawData> _monsters;

  GameData(List<UnitRawData> monsters) : this._monsters = monsters;

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  List<UnitRawData> get monsters => List.unmodifiable(_monsters);

  UnitRawData getUnitDataById(UnitType id) =>
      monsters.firstWhere((element) => element.id == id);

  UnitRawData getUnitDataByName(String query) =>
      monsters.firstWhere((element) => element.name == query);
}
