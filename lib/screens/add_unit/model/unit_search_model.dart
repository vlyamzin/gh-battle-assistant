import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:meta/meta.dart';

@immutable
class UnitSearch extends Equatable {
  final GameData data;

  const UnitSearch(this.data);

  Map<UnitType, String> getUnitNames() {
    return Map.fromIterable(data.monsters,
        key: (e) => e.id, value: (e) => e.name);
  }

  Map<UnitType, String> getSuggestions(String query) {
    var matches = <UnitType, String>{};
    matches.addAll(getUnitNames());

    matches.removeWhere(
        (_, value) => !value.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  List<Object?> get props => [data];
}
