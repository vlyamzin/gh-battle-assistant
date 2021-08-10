import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';

class UnitAction {
  late final int initiative;
  late final List<GHAction> values;
  late final Map<ModifierType, int> modifiers;
  late final bool? shouldRefresh;

  UnitAction({
    required this.initiative,
    values,
    modifiers,
    this.shouldRefresh,
  }) {
    this.values = values ?? [];
    this.modifiers = modifiers ?? <ModifierType, int>{};
  }

  factory UnitAction.fromRawData(UnitRawAction data) {
    return UnitAction(
      initiative: data.initiative,
      modifiers: data.modifier,
      shouldRefresh: data.shouldRefresh,
      values: data.values.map((e) => GHAction(
        title: e.title,
        subtitle: e.subtitle,
        area: e.area
      )).toList()
    );
  }
}

class GHAction {
  String? title;
  String? subtitle;
  String? area;

  GHAction({this.title, this.subtitle, this.area});
}
