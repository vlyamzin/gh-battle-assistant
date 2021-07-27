import 'package:gh_battle_assistant/models/unit_stack.dart';

class UnitAction {
  late final UnitType type;
  late final int? initiative;
  late final String? displayName;
  late final List<Action>? actions;
  late final bool? shouldRefresh;
  late final String? imgPath;

  UnitAction({
    required this.type,
    this.initiative,
    this.displayName,
    this.actions,
    this.shouldRefresh,
    this.imgPath,
  });

  UnitAction.fromJson(Map data)
      : this(
          // TODO add action generation here
          displayName: data['displayName'],
          actions: data['actions'],
          initiative: data['initiative'],
          shouldRefresh: data['shouldRefresh'],
          imgPath: data['imgPath'],
          type: data['type']
        );
}

class Action {
  String? title;
  String? subtitle;

  Action({this.title, this.subtitle});
}
