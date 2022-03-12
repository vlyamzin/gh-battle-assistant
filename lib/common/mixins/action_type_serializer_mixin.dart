import 'package:gh_battle_assistant/common/enums/activity_type.dart';
import 'package:gh_battle_assistant/common/enums/modifier_type.dart';

mixin ActionTypeSerializer {
  static Map<ModifierType, List<String>>? serializeRawModifier(
    Map<ModifierType, dynamic>? data,
  ) {
    return data?.map((key, value) {
          if (value is int) {
            return MapEntry(key, [value.toString()]);
          }

          if (value is Iterable) {
            return MapEntry(key, value.map((e) => e.toString()).toList());
          }

          if (value is String) {
            return MapEntry(key, [value]);
          }

          throw Exception('Serialize raw data exception. Unknown value type');
        }) ??
        {};
  }

  static Map<ActivityType, String>? serializeRawPerkValue(
      Map<String, String>? data) {
    return data?.map((key, value) {
          switch (key) {
            case 'pierce':
              return MapEntry(ActivityType.pierce, value);
            case 'target':
              return MapEntry(ActivityType.target, value);
            case 'pull':
              return MapEntry(ActivityType.pull, value);
            case 'push':
              return MapEntry(ActivityType.push, value);
            case 'heal':
              return MapEntry(ActivityType.heal, value);
            default:
              throw Exception('Serialize raw data exception');
          }
        }) ??
        {};
  }

  static List<ActivityType>? serializeRawData(List<String>? list) {
    return list?.map((value) {
      switch (value) {
        case 'pierce':
          return ActivityType.pierce;
        case 'poison':
          return ActivityType.poison;
        case 'wound':
          return ActivityType.wound;
        case 'disarm':
          return ActivityType.disarm;
        case 'immobilize':
          return ActivityType.immobilize;
        case 'muddle':
          return ActivityType.muddle;
        case 'curse':
          return ActivityType.curse;
        case 'bless':
          return ActivityType.bless;
        case 'stun':
          return ActivityType.stun;
        case 'invisible':
          return ActivityType.invisible;
        case 'strengthen':
          return ActivityType.strengthen;
        case 'pull':
          return ActivityType.pull;
        case 'push':
          return ActivityType.push;
        case 'heal':
          return ActivityType.heal;
        case 'target':
          return ActivityType.target;
        case 'advantage':
          return ActivityType.advantage;
        case 'disadvantage':
          return ActivityType.disadvantage;
        default:
          throw Exception('Serialize raw data exception');
      }
    }).toList();
  }
}
