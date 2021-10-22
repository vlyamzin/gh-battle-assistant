import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';

class EnemiesRepository {
  final GameData data;

  const EnemiesRepository(this.data);

  UnitRawData byId(UnitType id) => data.getUnitDataById(id);

  UnitRawData byName(String query) => data.getUnitDataByName(query);
}
