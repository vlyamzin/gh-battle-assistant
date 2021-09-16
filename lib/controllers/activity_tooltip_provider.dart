import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';

class ActivityTooltipProvider with ChangeNotifier {
  ActivityTooltipProvider({required this.activity, required this.counter});

  ActivityTooltipProvider.empty()
      : this(activity: ActivityType.attack, counter: 0);

  final ActivityType activity;
  int counter;
  bool _showTooltip = false;

  String get message => _prepareTooltipMessage();

  bool get showTooltip => _showTooltip;

  /// Update provider with new values
  ActivityTooltipProvider copyWith({ActivityType? activityType, int? counter}) {
    return ActivityTooltipProvider(
      activity: activityType ?? this.activity,
      counter: counter ?? this.counter,
    );
  }

  void toggleTooltip() {
    _showTooltip = counter != 0 ? true : false;
    notifyListeners();
  }

  @override
  void dispose() {
    _showTooltip = false;
    notifyListeners();
    super.dispose();
  }

  String _prepareTooltipMessage() {
    switch (activity) {
      case ActivityType.attack:
      case ActivityType.heal:
      case ActivityType.suffer:
      case ActivityType.pierce:
        return counter == 0 ? "" : counter.toString();
      default:
        if (counter > 0) return "On";
        if (counter < 0) return 'Off';
        return "";
    }
  }
}
