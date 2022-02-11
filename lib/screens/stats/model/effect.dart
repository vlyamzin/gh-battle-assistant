import 'package:gh_battle_assistant/models/enums/activity_type.dart';

typedef EffectMap = Map<ActivityType, String>;
typedef EffectMapEntry = MapEntry<ActivityType, String>;

class Effect {
  final int? id;
  final ActivityType type;
  final String iconShortcut;
  late final String? label;

  Effect(this.type, this.iconShortcut, [this.label = '', this.id]);

  @override
  int get hashCode => type.hashCode;

  @override
  bool operator ==(dynamic other) {
    if (other is! Effect) return false;
    Effect effect = other;
    return type == effect.type;
  }
}
