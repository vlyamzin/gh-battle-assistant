import 'package:gh_battle_assistant/models/enums/unit_type.dart';

class UnitAction {
  late final UnitType type;
  late final int? initiative;
  late final List<Action>? actions;
  late final bool? shouldRefresh;

  UnitAction({
    required this.type,
    this.initiative,
    this.actions,
    this.shouldRefresh,
  });

  UnitAction.fromJson(Map data)
      : this(
          // TODO add action generation here
          actions: data['actions'],
          initiative: data['initiative'],
          shouldRefresh: data['shouldRefresh'],
          type: data['type']
        );
}

class Action {
  String? title;
  String? subtitle;

  Action({this.title, this.subtitle});
}
