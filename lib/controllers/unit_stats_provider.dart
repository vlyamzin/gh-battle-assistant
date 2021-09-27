import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

import '../di.dart';

typedef DefaultStats = UnitRawStats;

/// Controller that is responsible for [StatsScreen] business logic and other manipulations
/// Implements [ChangeNotifier] Provider
class UnitStatsProvider with ChangeNotifier {
  final Unit unit;
  final DefaultStats defaultStats;
  final Map<ModifierType, int> modifiers;

  /// Main Constructor
  /// Requires params:
  /// unit [Unit]- All unit specific data
  /// modifiers [Map<ModifierType, int>] - Stat modifiers which comes from the [UnitAction] class
  /// defaultStats [UnitRawStats] - Default parameter. Are being used for refreshing stats after the specific activity
  UnitStatsProvider({
    required this.unit,
    required this.modifiers,
    required this.defaultStats,
  }) {
    this._activityHandlers = <ActivityType, Function(int)>{
      ActivityType.attack: _attack,
      ActivityType.heal: _heal,
      ActivityType.suffer: _sufferDamage,
      ActivityType.pierce: _pierceAttack,
      ActivityType.poison: _poisonAttack,
      ActivityType.wound: _woundAttack,
      ActivityType.disarm: _disarm,
      ActivityType.stun: _stun,
      ActivityType.muddle: _muddle,
      ActivityType.strengthen: _strengthen,
      ActivityType.immobilize: _immobilize,
      ActivityType.invisible: _invisible,
    };

    this.activeEffects = Set.from(
        unit.negativeEffects?.map((e) => Effect(e, defaultActivities[e]!)) ??
            {});
  }

  /// List of all activities that can affect [Unit] stats this round
  /// Are being used to render a proper icons from [ImageService]
  static final EffectMap defaultActivities =
      di<ImageService>().getAttackEffect(IconSize.s64);

  /// Define [ActivityType] types that are countable
  /// It means the counter for these types can be bigger than -1, 0, 1
  Set<ActivityType> _countable = const <ActivityType>{
    ActivityType.attack,
    ActivityType.heal,
    ActivityType.pierce,
    ActivityType.suffer
  };

  /// Set of active effects applied to [Unit]
  /// displays in ActiveEffects section of the [UnitStatsCard]
  late Set<Effect> activeEffects;

  /// Helper to proxy user action to a proper activity
  late final Map<ActivityType, Function> _activityHandlers;

  /// Counter for plus/minus buttons
  int _counter = 0;

  /// Selected activity. Defines which attack type will be made
  MapEntry<ActivityType, String> selectedActivity = defaultActivities.entries
      .firstWhere((activity) => activity.key == ActivityType.attack);

  /// Store files locally via [HomeScreenProvider]
  /// and notify listeners of Provider about changes
  void save() {
    di<HomeScreenProvider>().saveToStorage().then((_) => notifyListeners());
  }

  /// Return List of activities that are not blocked by unit immunity
  /// Exclude Pull, Push, Target, Bless and Curse as these activities don't affect unit stats in any way
  /// This list is being used in activity selection tooltip
  Iterable<MapEntry<ActivityType, String>> get availableActivities {
    final exclude = [
      ActivityType.pull,
      ActivityType.push,
      ActivityType.bless,
      ActivityType.curse,
      ActivityType.target_2,
      ActivityType.target_3,
      ActivityType.target_4,
      ActivityType.target_all,
    ];
    return defaultActivities.entries.where(
      (activity) =>
          !unit.immune!.contains(activity.key) &&
          !exclude.contains(activity.key),
    );
  }

  /// Return List of immune [Effect]
  /// This list is rendered in 'Immune to' section of [UnitStatsCard]
  List<Effect?> get immuneEffects {
    return unit.immune != null
        ? unit.immune!.map((e) => Effect(e, defaultActivities[e]!)).toList()
        : [];
  }

  /// Return List of attack [Effect]
  /// This list is rendered in 'Attack effects' section of [UnitStatsCard]
  List<Effect?> get attackEffects {
    return unit.perks != null
        ? unit.perks!.map((p) => Effect(p, defaultActivities[p]!)).toList()
        : [];
  }

  /// Return List of area images as path to assets
  List<String> get areaEffects {
    return unit.area.map((i) => di<ImageService>().getIcon(i)).toList();
  }

  /// Public getter for [_counter] value
  int get counter => _counter;

  /// Check if unit has enough health point to be treated like alive
  bool get isUnitDead => unit.healthPoint <= 0;

  /// Check if unit has Poison [ActivityType]
  bool get isPoisoned =>
      unit.negativeEffects?.contains(ActivityType.poison) ?? false;

  /// Check if unit has Wound [ActivityType]
  bool get isWounded =>
      unit.negativeEffects?.contains(ActivityType.wound) ?? false;

  /// Check if unit has Pierce [ActivityType]
  bool get isPierced => unit.pierced > 0;

  /// Handler to user action of activity selection from the available pull
  void selectActivity(MapEntry<ActivityType, String> activity) {
    selectedActivity = activity;
    _counter = 0;
    notifyListeners();
  }

  /// Increase activity status
  // void plusActivity() => _activityHandlers[selectedActivity.key]!(1);
  void plusActivity() {
    if (_countable.contains(selectedActivity.key)) {
      _counter += 1;
    } else {
      _counter = 1;
    }
    notifyListeners();
  }

  /// Decrease activity status
  void minusActivity() {
    if (_countable.contains(selectedActivity.key)) {
      _counter = _counter > 0 ? _counter - 1 : 0;
    } else {
      _counter = -1;
    }
    notifyListeners();
  }

  /// Apply [_counter] value for selected activity
  void applyActivity() {
    _activityHandlers[selectedActivity.key]!(_counter);
    _counter = 0;
    notifyListeners();
  }

  /// Regular attack activity.
  /// Changes [Unit.healthPoint] and/or [Unit.shield]
  /// Can be affected by [ActivityType.poison] or [ActivityType.pierce]
  ///
  /// Example 1:
  /// Unit has:
  ///   healthPoint: 5
  ///   shield: 4
  /// Attack is:
  ///   pierce: 2
  ///   attack: 3
  /// Result will be:
  ///   damage = attack + poison + (shield - pierce)
  ///   damage = 3 + 0 - (4 - 2) = 1
  ///   healthPoint = 5 - 1 = 4
  ///
  /// Example 2:
  /// Unit has:
  ///   healthPoint: 5
  ///   shield: 6
  /// Attack is:
  ///   pierce: 2
  ///   attack: 3
  /// Result will be:
  ///   damage = attack + poison + (shield - pierce)
  ///   damage = 3 + 0 - (6 - 2) = -1
  ///   healthPoint = 5 (as damage is less than 0)
  ///
  ///
  /// Example 3:
  /// Unit has:
  ///   healthPoint: 5
  ///   shield: 1
  /// Attack is:
  ///   pierce: 2
  ///   attack: 3
  /// Result will be:
  ///   damage = attack + poison + (shield - pierce)
  ///   damage = 3 + 0 - (1 - 2) = 4
  ///   healthPoint = 5 - 4 = 1
  void _attack(int value) {
    var damagedShield = unit.shield - unit.pierced;

    while (damagedShield > 0 && value > 0) {
      damagedShield--;
      value--;
    }

    if (damagedShield >= 0)
      unit.shield = damagedShield + unit.pierced;
    else
      value += -damagedShield;

    unit.healthPoint -= value;
    unit.pierced = 0;

    save();
  }

  /// Heal activity
  /// Works opposite to suffer damage activity
  /// Increases the number of [Unit] health point
  void _heal(int value) {
    _toggleEffect(-1, ActivityType.wound);

    if (isPoisoned) {
      _toggleEffect(-1, ActivityType.poison);
      return;
    }

    unit.healthPoint += value;
    save();
  }

  /// Suffer damage activity
  /// Works opposite to heal activity
  /// Decreases the number of [Unit] health point
  /// Ignores [Unit] shield
  void _sufferDamage(int value) {
    if (!isUnitDead) unit.healthPoint -= value;
    save();
  }

  /// Piece attack activity
  /// Modify [Unit.pierced] value
  /// Define how much damage will pass through [Unit.shield]
  /// Refreshes after the end of round
  void _pierceAttack(int value) {
    // unit.negativeEffects?.add(ActivityType.pierce);
    unit.pierced = value;
    // if (unit.shield != null && unit.shield! > 0)
    //   unit.shield = unit.shield! - value;
    save();
  }

  void _poisonAttack(int value) => _toggleEffect(value, ActivityType.poison);

  void _woundAttack(int value) => _toggleEffect(value, ActivityType.wound);

  void _disarm(int value) {
    if (value > 0) {
      unit.attack = 0;
    } else {
      if (defaultStats.attack != null) {
        unit.attack =
            defaultStats.attack! + (modifiers[ModifierType.attack] ?? 0);
      }
    }
    _toggleEffect(value, ActivityType.disarm);
  }

  void _immobilize(int value) {
    if (value > 0) {
      unit.move = 0;
    } else {
      if (defaultStats.move != null) {
        unit.move = defaultStats.move! + (modifiers[ModifierType.move] ?? 0);
      }
    }
    _toggleEffect(value, ActivityType.immobilize);
  }

  void _stun(int value) => _toggleEffect(value, ActivityType.stun);

  void _muddle(int value) => _toggleEffect(value, ActivityType.muddle);

  void _strengthen(int value) => _toggleEffect(value, ActivityType.strengthen);

  void _invisible(int value) => _toggleEffect(value, ActivityType.invisible);

  void _toggleEffect(int value, ActivityType effectType) {
    if (value > 0) {
      activeEffects = {
        ...activeEffects,
        Effect(effectType, defaultActivities[effectType]!)
      };
      unit.negativeEffects?.add(effectType);
    } else if (value < 0) {
      // hack for Provider.Selector
      activeEffects = {...activeEffects};
      activeEffects.remove(
        Effect(effectType, defaultActivities[effectType]!),
      );
      unit.negativeEffects?.remove(effectType);
    }

    save();
    notifyListeners();
  }
}

// TODO Move into a separate file in model/ folder [069640eea5965a350fea04bebaceedb9]
typedef EffectMap = Map<ActivityType, String>;
typedef EffectMapEntry = MapEntry<ActivityType, String>;

class Effect {
  final ActivityType type;
  final String iconShortcut;

  Effect(this.type, this.iconShortcut);

  @override
  int get hashCode => type.hashCode;

  @override
  bool operator ==(dynamic other) {
    if (other is! Effect) return false;
    Effect effect = other;
    return type == effect.type;
  }
}
