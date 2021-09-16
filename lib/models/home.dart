import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable(explicitToJson: true)
class Home {
  List<UnitStack> _monsters;

  Home({List<UnitStack>? monsters}) : this._monsters = monsters ?? [];

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);

  List<UnitStack> get monsters => List.unmodifiable(_monsters);

  UnitStack? getByType(UnitType type) {
    try {
      return monsters.firstWhere((element) => element.type == type);
    } on StateError catch (_) {
      return null;
    }
  }

  void add(UnitStack data) {
    _monsters.add(data);
  }

  void remove(UnitType id) {
    _monsters.removeWhere((element) => element.type == id);
  }

  void update(UnitStack data) {
    var index = _monsters.indexWhere((m) => m.type == data.type);
    _monsters[index] = UnitStack.copy(data);
  }
}
