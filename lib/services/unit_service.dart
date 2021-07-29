import 'package:gh_battle_assistant/models/enums/unit_type.dart';

class UnitService {
  static final unitNames = <UnitType, String>{
    UnitType.banditArcher: 'Bandit Archer',
    UnitType.banditGuard: 'Bandit Guard',
    UnitType.ancientArtillery: 'Ancient Artillery',
  };

  static Map<UnitType, String> getSuggestions(String query) {
    var matches = <UnitType, String>{};
    matches.addAll(unitNames);

    matches.removeWhere((_, value) => !value.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static MapEntry<UnitType, String>? itemByName(String value) {
    var el = unitNames.entries.firstWhere((element) => element.value == value);
    return el;
  }
}
